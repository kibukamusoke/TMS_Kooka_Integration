<?php
/**
 * IDE: PhpStorm.
 * Created by: Trevor
 * Date: 4/25/19
 * Time: 12:19 PM
 */

class TerminalData
{
    private $__DB, $__GB, $__Sec;

    public function __construct($__DB, $__GB, $__Sec)
    {
        $this->__DB = $__DB;
        $this->__GB = $__GB;
        $this->__Sec = $__Sec;
    }

    public function updateTerminal($tmn_hw_id)
    {
        $this->__GB->__DB->query("CALL sp_buildAllFiles($tmn_hw_id, @output);");
        $query = $this->__GB->__DB->query('SELECT @output');
        $result = $this->__GB->__DB->fetch_array($query);
        return $result[0];
    }

    public function terminalOfflineAction($tmn_hw_id, $action_id, $data)
    {
        $this->__GB->__DB->query("CALL sp_tmn_offline_action($tmn_hw_id,$action_id,'$data' @output);");
        $query = $this->__GB->__DB->query('SELECT @output');
        $result = $this->__GB->__DB->fetch_array($query);
        return $result[0];
    }


}