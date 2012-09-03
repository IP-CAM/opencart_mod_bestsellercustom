<?php
class ModelModuleBestsellercustom extends Model {
    
    private $module = "bestsellercustom";
    
    public function getBestSellerCustomProducts($limit, $filter = null)
    {
        $this->load->model('catalog/product');
        
        $limit = (int)$limit;
        
        $language_id       = (int)$this->config->get('config_language_id');
        $store_id          = (int)$this->config->get('config_store_id');
        $customer_group_id = $this->config->get('config_customer_group_id');
        $filter_id         = 0;
        
        if($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        }
        
        if(is_string($filter) && $filter != 'none') {
            if(!empty($this->request->get["path"])) {
                $filter_temp = explode('_', $this->request->get["path"]);
                
                $filter    = "category";
                $filter_id = (int)$filter_temp[0];
            } elseif(!empty($this->request->get["manufacturer_id"])) {
                $filter    = "manufacturer";
                $filter_id = (int)$this->request->get["manufacturer_id"];
            }
        }
        
        $cache_data = $this->cache->get('product.'.$this->module.'.'.$language_id.'.'.$store_id.'.'.$customer_group_id.'.'.$filter.'-'.$filter_id.'.'.$limit);
        
        if(!$cache_data) {
            $cache_data = array();
            
            $sql = "SELECT p.`product_id`, (
                    SELECT COUNT(op.order_id)
                    FROM `".DB_PREFIX."order_product` op
                        LEFT JOIN `".DB_PREFIX."order` o ON op.`order_id` = o.`order_id`
                    WHERE op.`product_id` = p.`product_id`
                    AND o.`order_status_id` > '0'
                ) AS total
                FROM `".DB_PREFIX."product` p
                    LEFT JOIN `".DB_PREFIX."product_to_category` p2c ON p.`product_id` = p2c.`product_id`
                    LEFT JOIN `".DB_PREFIX."product_to_store` p2s ON p.`product_id` = p2s.`product_id`
                WHERE p.`status` = '1'
                AND p.`date_available` <= '".date('Y-m-d')."'
                AND p2s.`store_id` = '".(int)$this->config->get('config_store_id')."' ";
            
            if(!empty($filter_id)) {
                if($filter == 'category') {
                    $sql.= "AND p2c.`category_id` = ".$filter_id." ";
                } elseif($filter == 'manufacturer') {
                    $sql.= "AND p.`manufacturer_id` = ".$filter_id." ";
                }
            }
            
            $sql.= "GROUP BY p.`product_id`
                ORDER BY total DESC, p.`viewed` DESC
                LIMIT ".(int)$limit;
            
            $query = $this->db->query($sql);
            
            foreach($query->rows as $result) {
                $cache_data[$result["product_id"]] = $this->model_catalog_product->getProduct($result["product_id"]);
            }
            
            $this->cache->set('product.'.$this->module.'.'.$language_id.'.'.$store_id.'.'.$customer_group_id.'.'.$filter.'-'.$filter_id.'.'.$limit, $cache_data);
        }
        
        return $cache_data;
    }
    
}