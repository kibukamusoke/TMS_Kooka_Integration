<?php
/**
 * IDE: PhpStorm.
 * Created by: Trevor
 * Date: 4/25/19
 * Time: 12:14 PM
 */


include_once('init.php');

switch ($_GET['type']) {
    case 'update':
        echo($__TMS->updateTerminal($__DB->escape_string($_GET['tmn_hw_id'])));
        break;
    case 'action':
        echo($__TMS->terminalOfflineAction($__DB->escape_string($_GET['tmn_hw_id']), $__DB->escape_string($_GET['action_id']), $_POST));
        break;
    default:
        //http_response_code(404);
        die($__GB->terminalFormulateOutputString('4', 'ERROR', 'Invalid Action', '', '', ''));
        break;
}