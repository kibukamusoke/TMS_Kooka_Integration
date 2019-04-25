<?php
/**
 * IDE: PhpStorm.
 * Created by: Trevor
 * Date: 10/11/18
 * Time: 9:32 PM
 */

include_once('TerminalData.php');

class Factory
{
    public static function TerminalData($__DB, $__GB, $__Sec)
    {
        return new TerminalData($__DB, $__GB, $__Sec);
    }
}
