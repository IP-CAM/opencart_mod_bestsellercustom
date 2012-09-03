<?php $module_row = 0; ?>

<?= $header ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach($breadcrumbs as $breadcrumb) : ?>
            <?= $breadcrumb["separator"] ?><a href="<?= $breadcrumb["href"] ?>"><?= $breadcrumb["text"] ?></a>
        <?php endforeach; ?>
    </div>
    <?php if($error_warning) : ?>
        <div class="warning"><?= $error_warning ?></div>
    <?php endif; ?>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/module.png" alt="" /> <?= $heading_title ?></h1>
            <div class="buttons">
                <a onclick="$('#form').submit();" class="button"><span><?= $button_save ?></span></a>
                <a onclick="location = '<?= $cancel ?>';" class="button"><span><?= $button_cancel ?></span></a>
            </div>
        </div>
        <div class="content">
            <form action="<?= $action ?>" method="post" enctype="multipart/form-data" id="form">
                <table id="module" class="list">
                    <thead>
                        <tr>
                            <td class="left"><?= $entry_limit ?></td>
                            <td class="left"><?= $entry_image ?></td>
                            <td class="left"><?= $entry_layout ?></td>
                            <td class="left"><?= $entry_position ?></td>
                            <td class="left"><?= $entry_filter ?></td>
                            <td class="left"><?= $entry_status ?></td>
                            <td class="right"><?= $entry_sort_order ?></td>
                            <td></td>
                        </tr>
                    </thead>
                    <?php foreach($modules as $module) : ?>
                        <tbody id="module-row-<?= $module_row ?>">
                            <tr>
                                <td class="left">
                                    <input type="text" name="<?= $module_name ?>_module[<?= $module_row ?>][limit]" value="<?= $module["limit"] ?>" size="1" />
                                    <?php if(isset($error_limit[$module_row])) : ?>
                                        <span class="error"><?= $error_limit[$module_row] ?></span>
                                    <?php endif; ?>
                                </td>
                                <td class="left">
                                    <input type="text" name="<?= $module_name ?>_module[<?= $module_row ?>][image_width]" value="<?= $module["image_width"] ?>" size="2" />
                                    <input type="text" name="<?= $module_name ?>_module[<?= $module_row ?>][image_height]" value="<?= $module["image_height"] ?>" size="2" />
                                    <?php if(isset($error_image[$module_row])) : ?>
                                        <span class="error"><?= $error_image[$module_row] ?></span>
                                    <?php endif; ?>
                                </td>
                                <td class="left">
                                    <select name="<?= $module_name ?>_module[<?= $module_row ?>][layout_id]">
                                        <?php foreach($layouts as $layout) : ?>
                                            <option value="<?= $layout["layout_id"] ?>"
                                                <?php if($layout["layout_id"] == $module["layout_id"]) : ?>
                                                    selected="selected"
                                                <?php endif; ?>
                                            ><?= $layout["name"] ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </td>
                                <td class="left">
                                    <select name="<?= $module_name ?>_module[<?= $module_row ?>][position]">
                                        <option value="content_top"
                                            <?php if($module["position"] == 'content_top') : ?>selected="selected"<?php endif; ?>
                                        ><?= $text_content_top ?></option>
                                        <option value="content_bottom"
                                            <?php if($module["position"] == 'content_bottom') : ?>selected="selected"<?php endif; ?>
                                        ><?= $text_content_bottom ?></option>
                                        <option value="column_left"
                                            <?php if($module["position"] == 'column_left') : ?>selected="selected"<?php endif; ?>
                                        ><?= $text_column_left ?></option>
                                        <option value="column_right"
                                            <?php if($module["position"] == 'column_right') : ?>selected="selected"<?php endif; ?>
                                        ><?= $text_column_right ?></option>
                                    </select>
                                </td>
                                <td class="left">
                                    <select name="<?= $module_name ?>_module[<?= $module_row ?>][filter]">
                                        <option value="all"
                                            <?php if($module["filter"] == 'all') : ?>selected="selected"<?php endif; ?>
                                        ><?= $text_all ?></option>
                                        <option value="category"
                                            <?php if($module["filter"] == 'category') : ?>selected="selected"<?php endif; ?>
                                        ><?= $text_category ?></option>
                                        <option value="manufacturer"
                                            <?php if($module["filter"] == 'manufacturer') : ?>selected="selected"<?php endif; ?>
                                        ><?= $text_manufacturer ?></option>
                                    </select>
                                </td>
                                <td class="left">
                                    <select name="<?= $module_name ?>_module[<?= $module_row ?>][status]">
                                        <?php if($module["status"]) : ?>
                                            <option value="1" selected="selected"><?= $text_enabled ?></option>
                                            <option value="0"><?= $text_disabled ?></option>
                                        <?php else : ?>
                                            <option value="1"><?= $text_enabled ?></option>
                                            <option value="0" selected="selected"><?= $text_disabled ?></option>
                                        <?php endif; ?>
                                    </select>
                                </td>
                                <td class="right">
                                    <input type="text" name="<?= $module_name ?>_module[<?= $module_row ?>][sort_order]" value="<?= $module["sort_order"] ?>" size="1" />
                                </td>
                                <td class="left">
                                    <a href="#" rev="<?= $module_row ?>" class="button jq_button_remove"><?= $button_remove ?></a>
                                </td>
                            </tr>
                        </tbody>
                        <?php $module_row++; ?>
                    <?php endforeach; ?>
                    <tfoot>
                        <tr>
                            <td colspan="7"></td>
                            <td class="left"><a href="#" class="button jq_button_add"><?php echo $button_add_module; ?></a></td>
                        </tr>
                    </tfoot>
                </table>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
    var module_row = <?= $module_row ?>;
    
    $('.jq_button_remove').live('click', function() {
        $('#module-row-' + $(this).attr('rev')).remove();
        
        return false;
    });
    
    $('.jq_button_add').click(function() {
        console.log(module_row);
        
        $('#module > tfoot').before($('<tbody>').attr('id', 'module-row-' + module_row)
            .append($('<tr>'))
                .append($('<td>').addClass('left')
                    .append($('<input>')
                        .val('5')
                        .attr('type', 'text')
                        .attr('name', '<?= $module_name ?>_module[' + module_row + '][limit]')
                        .attr('size', 1)
                    )
                )
                .append($('<td>').addClass('left')
                    .append($('<input>')
                        .val('80')
                        .attr('type', 'text')
                        .attr('name', '<?= $module_name ?>_module[' + module_row + '][image_width]')
                        .attr('size', 2)
                    )
                    .append($('<input>')
                        .val('80')
                        .attr('type', 'text')
                        .attr('name', '<?= $module_name ?>_module[' + module_row + '][image_height]')
                        .attr('size', 2)
                    )
                )
                .append($('<td>').addClass('left')
                    .append($('<select>')
                        .attr('name', '<?= $module_name ?>_module[' + module_row + '][layout_id]')
                        <?php foreach($layouts as $layout) : ?>
                            .append($('<option>')
                                .val('<?= $layout["layout_id"] ?>')
                                .text('<?= $layout["name"] ?>')
                            )
                        <?php endforeach; ?>
                    )
                )
                .append($('<td>').addClass('left')
                    .append($('<select>')
                        .attr('name', '<?= $module_name ?>_module[' + module_row + '][position]')
                        .append($('<option>')
                            .val('content_top')
                            .text('<?= $text_content_top ?>')
                        )
                        .append($('<option>')
                            .val('content_bottom')
                            .text('<?= $text_content_bottom ?>')
                        )
                        .append($('<option>')
                            .val('column_left')
                            .text('<?= $text_column_left ?>')
                        )
                        .append($('<option>')
                            .val('column_right')
                            .text('<?= $text_column_right ?>')
                        )
                    )
                )
                .append($('<td>').addClass('left')
                    .append($('<select>')
                        .attr('name', '<?= $module_name ?>_module[' + module_row + '][filter]')
                        .append($('<option>')
                            .val('all')
                            .text('<?= $text_all ?>')
                        )
                        .append($('<option>')
                            .val('category')
                            .text('<?= $text_category ?>')
                        )
                        .append($('<option>')
                            .val('manufacturer')
                            .text('<?= $text_manufacturer ?>')
                        )
                    )
                )
                .append($('<td>').addClass('left')
                    .append($('<select>')
                        .attr('name', '<?= $module_name ?>_module[' + module_row + '][status]')
                        .append($('<option>')
                            .val('1')
                            .text('<?= $text_enabled ?>')
                        )
                        .append($('<option>')
                            .val('0')
                            .text('<?= $text_disabled ?>')
                        )
                    )
                )
                .append($('<td>').addClass('right')
                    .append($('<input>')
                        .attr('type', 'text')
                        .attr('name', '<?= $module_name ?>_module[' + module_row + '][sort_order]')
                        .attr('size', 1)
                    )
                )
                .append($('<td>').addClass('left')
                    .append($('<a>').addClass('button').addClass('jq_button_remove')
                        .attr('href', '#')
                        .attr('rev', module_row)
                        .text('<?= $button_remove ?>'))
                )
            );
        
        module_row++;
        
        return false;
    });
</script>
<?= $footer ?>