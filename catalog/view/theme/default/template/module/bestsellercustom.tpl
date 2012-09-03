<div class="box">
    <div class="box-heading"><?= $heading_title ?></div>
    <div class="box-content">
        <div class="box-product">
            <?php foreach($products as $product) : ?>
                <div>
                    <?php if($product["thumb"]) : ?>
                        <div class="image">
                            <a href="<?= $product["href"] ?>"><img src="<?= $product["thumb"] ?>" alt="<?= $product["name"] ?>" /></a>
                        </div>
                    <?php endif; ?>
                    <div class="name"><a href="<?= $product["href"] ?>"><?= $product["name"] ?></a></div>
                    <?php if($product["price"]) : ?>
                        <div class="price">
                            <?php if(!$product["special"]) : ?>
                                <?= $product["price"] ?>
                            <?php else : ?>
                                <span class="price-old"><?= $product["price"] ?></span> <span class="price-new"><?= $product["special"] ?></span>
                            <?php endif; ?>
                        </div>
                    <?php endif; ?>
                    <?php if($product["rating"]) : ?>
                        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?= $product["rating"] ?>.png" alt="<?= $product["reviews"] ?>" /></div>
                    <?php endif; ?>
                    <div class="cart"><input type="button" value="<?= $button_cart ?>" onclick="addToCart('<?= $product["product_id"] ?>');" class="button" /></div>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</div>