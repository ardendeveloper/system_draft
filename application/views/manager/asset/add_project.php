<div class="content-wrapper">
	<ol class="breadcrumb">
		<li><a href="<?php echo base_url();?>ems/dashboard" class="btn btn-default"><i class="fa fa-dashboard"></i> Dashboard</a></li>
		<li><a href="<?php echo base_url();?>ams/view_projects" class="btn btn-default"><i class="fa fa-user"></i> Employees</a></li>
		<li class="active">Add Project</li>
	</ol>
	<div class="container-fluid">
		<div class="box box-info box-solid">
			<div class="box-header with-border">
				<h3 class="box-title big">Add New Project</h3>
			</div>
			<div class="box-body">
				<label>
					<small>Fields with * asterisk are required.</small>
				</label>
				<div class="box box-default box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">Project Information</h3>
					</div>
					<div class="box-body">
						<?php echo form_open('ams/add_project'); ?>
							<div class="form-horizontal">
								<div class="form-group">
									<label class=" col-sm-3 control-label">Project ID: * </label>
									<div class="col-sm-3">
										<input type="text" class="form-control input-sm" name="txtProjectID">
									</div>
									<div class="col-sm-5 error">
										<?php echo form_error('txtProjectID'); ?>
									</div>
								</div>
								<div class="form-group">
									<label class=" col-sm-3 control-label">Project Name: * </label>
									<div class="col-sm-3">
										<input type="text" class="form-control input-sm" name="txtProjectName">
									</div>
									<div class="col-sm-5 error">
										<?php echo form_error('txtProjectName'); ?>
									</div>
								</div>
								<div class="form-group">
									<label class=" col-sm-3 control-label">Client Name: * </label>
									<div class="col-sm-3">
										<input type="text" class="form-control input-sm" name="txtClient">
									</div>
									<div class="col-sm-5 error">
										<?php echo form_error('txtClient'); ?>
									</div>
								</div>
								<div class="form-group">
									<label class=" col-sm-3 control-label">Starting Date: * </label>
									<div class="col-sm-3">
										<input type="text" data-provide="datepicker" data-date-format="yyyy-mm-dd" class="form-control input-sm" name="txtStartingDate">
									</div>
									<div class="col-sm-5 error">
										<?php echo form_error('txtStartingDate'); ?>
									</div>
								</div>
								<div class="form-group">
									<label class=" col-sm-3 control-label">Ending Date: * </label>
									<div class="col-sm-3">
										<input type="text" data-provide="datepicker" data-date-format="yyyy-mm-dd" class="form-control input-sm" name="txtEndingDate">
									</div>
									<div class="col-sm-5 error">
										<?php echo form_error('txtEndingDate'); ?>
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
