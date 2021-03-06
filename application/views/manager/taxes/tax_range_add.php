<div class="content-wrapper">
    <ol class="breadcrumb">
        <li><a href="<?php echo base_url();?>ems/dashboard" class="btn btn-default"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="<?php echo base_url();?>payroll/taxes" class="btn btn-default"><i class="fa fa-user"></i> Taxes</a></li>
        <li><a href="<?php echo base_url();?>payroll/tax_range?id=<?php echo $tax_id; ?>" class="btn btn-default"><i class="fa fa-dashboard"></i> Tax Ranges</a></li>
        <li class="active">Add Tax Range</li>
    </ol>
    <div class="container-fluid">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title big">Add new Tax Type</h3>
            </div>
            <div class="panel-body">
                <label>
                    <small>Fields with * asterisk are required.</small>
                </label>
                <?php echo form_open('payroll/tax_range_add'); ?>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Tax Information</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class=" col-sm-3 control-label">Amount From: * </label>
                                <div class="col-sm-3">
									<input type="hidden" name="txtTaxID" value="<?php echo $tax_id; ?>">
                                    <input type="text" class="form-control input-sm" name="txtAmountFrom" value="<?php echo set_value('txtAmountFrom'); ?>">
                                </div>
                                <div class="col-sm-5 error">
                                    <?php echo form_error('txtTaxType'); ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-3 control-label">Amount To: * </label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control input-sm" name="txtAmountTo" value="<?php echo set_value('txtAmountTo'); ?>">
                                </div>
                                <div class="col-sm-5 error">
                                    <?php echo form_error('txtAmount'); ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-3 control-label">Amount Deduction: * </label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control input-sm" name="txtAmountDeducted" value="<?php echo set_value('txtAmountDeducted'); ?>">
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
