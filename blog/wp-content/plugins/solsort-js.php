<?php
/**
 * @package solsort.js
 * @version 0.0.1
 */
/*
Plugin Name: solsort.js
Description: Just add solsort.js to page
Author: RasmusErik
Version: 0.0.1
Author URI: https://solsort.com
*/


function script_solsortjs() {
	echo '<script src="/solsort.js"></script>';
}

add_action( 'wp_print_footer_scripts', 'script_solsortjs' );

?>
