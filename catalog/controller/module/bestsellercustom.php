<?php
class ControllerModuleBestsellercustom extends Controller
{
    private $module = "bestsellercustom";
    
    protected function index($setting)
    {
        $this->language->load('module/'.$this->module);
        
        $this->load->model('module/'.$this->module);
        $this->load->model('tool/image');
        
        $this->data["heading_title"] = $this->language->get('heading_title');				
		$this->data["button_cart"] = $this->language->get('button_cart');
        
        $this->data['products'] = array();
        
        eval('$products = $this->model_module_'.$this->module.'->get'.$this->module.'Products($setting["limit"], $setting["filter"]);');
        
        foreach($products as $product) {
            if(($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($product["price"], $product["tax_class_id"], $this->config->get('config_tax')));
            } else {
                $price = false;
            }
            
            $this->data["products"][] = array('product_id' => $product["product_id"],
                'thumb'   	 => $product["image"] ? $this->model_tool_image->resize($product["image"], $setting['image_width'], $setting['image_height']) : false,
                'name'    	 => $product["name"],
                'price'   	 => $price,
                'special' 	 => (float)$product["special"] ? $this->currency->format($this->tax->calculate($product["special"], $product["tax_class_id"], $this->config->get('config_tax'))) : false,
                'rating'     => $this->config->get('config_review_status') ? $product["rating"] : false,
                'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product["reviews"]),
                'href'    	 => $this->url->link('product/product', 'product_id=' . $product["product_id"]),
			);
        }
        
        if(file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/module/'.$this->module.'.tpl')) {
			$this->template = $this->config->get('config_template')."/template/module/".$this->module.".tpl";
		} else {
			$this->template = "default/template/module/".$this->module.".tpl";
		}

		$this->render();
    }
    
}