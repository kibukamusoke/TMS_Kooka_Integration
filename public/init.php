<?php
/**
 * IDE: PhpStorm.
 * Created by: Trevor
 * Date: 4/25/19
 * Time: 12:01 PM
 */

require_once('config.php');

require_once('classes/Database.php');
require_once('classes/General.php');
require_once('classes/Security.php');
require_once('classes/TerminalData.php');

$__DB = new Database($_CONFIG['Database']);
$__DB->connect();
$__DB->select_db();

$__Sec 	= new Security($__DB);
$__GB 	= new General($__DB,$__Sec, $_CONFIG['CONSTANTS']);
$__TMS = new TerminalData($__DB, $__GB, $__Sec);


/*********************** ACCEPT FORM POSTED DATA *********************************/
// handle json post data posted as a form ..
$json = file_get_contents('php://input');
if(empty($_POST)){
    $_POST = json_decode($json , true);
}
/*********************** ACCEPT FORM POSTED DATA DONE *****************************/


?>