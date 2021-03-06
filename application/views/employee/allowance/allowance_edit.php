<div class="content-wrapper">
    <ol class="breadcrumb">
        <li><a href="<?php echo base_url();?>ems/dashboard" class="btn btn-default"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="<?php echo base_url();?>payroll/allowances" class="btn btn-default"><i class="fa fa-user"></i> Allowances</a></li>
        <li class="active">Edit Allowance Type</li>
    </ol>
    <div class="container-fluid">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title big">Edit Allowance Type</h3>
            </div>
            <div class="panel-body">
                <label>
                    <small>Fields with * asterisk are required.</small>
                </label>
                <?php echo form_open('payroll/allowances_edit'); ?>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Allowance Information</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class=" col-sm-3 control-label">Allowance Type: * </label>
                                <div class="col-sm-3">
									<input type="hidden" name="txtAllowanceID" value="<?php echo $allowance->allowance_id; ?>">
                                    <input type="text" class="form-control input-sm" name="txtAllowanceType" value="<?php echo (set_value('txtAllowanceType'))?set_value('txtAllowanceType'):$allowance->allowance_name; ?>">
                                </div>
                                <div class="col-sm-5 error">
                                    <?php echo form_error('txtAllowanceType'); ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-3 control-label">Amount: * </label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control input-sm" name="txtAmount" value="<?php echo (set_value('txtAmount'))?set_value('txtAmount'):$allowance->amount; ?>">
                                </div>
                                <div class="col-sm-5 error">
                                    <?php echo form_error('txtAmount'); ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-3 control-label">Percentage: * </label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control input-sm" name="txtPercentage" value="<?php echo (set_value('txtPercentage'))?set_value('txtPercentage'):$allowance->percentage; ?>">
                                </div>
                                <div class="col-sm-5 error">
                                    <?php echo form_error('txtPercentage'); ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-3 control-label">Status: </label>
                                <div class="col-sm-3">
                                    <input type="checkbox" name="chkStatus" <?php if($allowance->active==1) echo 'checked'; ?>>
                                </div>
                                <div class="col-sm-5 error">
                                    <?php echo form_error('txtPercentage'); ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="signupButtons">
                    <center>
                        <input type="submit" class="btn btn-success" name="btnSubmit" value="Submit">
                        <input type="reset" class="btn btn-danger" value="Clear">
                    </center>
                </div>
                <?php echo form_close(); ?>
            </div>
            <!-- Main Panel Body-->
        </div>
        <!-- End of Main Panel -->
    </div>
</div>
<!-- End of Wrapper -->
