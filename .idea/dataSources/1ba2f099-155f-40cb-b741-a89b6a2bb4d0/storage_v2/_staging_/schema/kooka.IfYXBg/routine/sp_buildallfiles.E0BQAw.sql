create procedure sp_buildAllFiles(IN `_tmn_hw_id` bigint, OUT output text)
  proc: BEGIN

    SELECT (CONCAT(
              fn_buildContainerFile(),
              fn_buildTerminalStepTemplateJrReceive(),
              fn_buildTerminalStepTemplateJrTransfer()
              fn_buildContainerFileForGF(),
              fn_buildStockFileForGF(),
              fn_buildPOFileForGF(),
              fn_buildPOStockFileForGF()
        )) INTO output;


  end;

