<?php
/**
 * @package solsort.js
 * @version 0.0.2
 */
/*
Plugin Name: solsort.js
Description: Just add solsort.js to page
Author: RasmusErik
Version: 0.0.2
Author URI: https://solsort.com
*/


function script_solsortjs() {
	echo '<script src="/solsort.js"></script>';
}

add_action( 'wp_print_footer_scripts', 'script_solsortjs' );

/**
 * Solsort Logo Widget
 */
class solsort_logo extends WP_Widget {
    /** constructor */
    function __construct() {
        parent::WP_Widget(false, $name = 'Solsort logo');  
    }
    /** @see WP_Widget::widget */
    function widget($args, $instance) { 
        ?>
<aside style="text-align: center" class="widget">
  <a href="https://solsort.com/">
    <img src=/icons/solsort.png width=50%>
    <h2 class="widget-title">solsort.com</h2>
  </a>
</aside>
<?php
    }
}
add_action('widgets_init', create_function('', 'return register_widget("solsort_logo");'));
?>
