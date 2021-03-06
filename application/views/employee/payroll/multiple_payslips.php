<div class="content-wrapper">
	<ol class="breadcrumb">
        <li><a href="<?php echo base_url();?>admin/dashboard" class="btn btn-default"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="<?php echo base_url();?>payroll/payroll_index" class="btn btn-default"><i class="fa fa-user"></i> Payroll</a></li>
        <li class="active"><i class="fa fa-search"></i> Generate Multiple Payslips </li>
    </ol>
	<div class="container-fluid">
		<div class="panel panel-info">
			<form action="<?php echo base_url();?>payroll/multiple_payslips" method="post">
			<div class="panel-heading">
			    <div class="row">
					<div class="col-sm-2">
			    		<div class="row">
							<label for="txtPayrollDate" class="control-label">Payroll Date: </label>
							<div class="col-sm-2 error"><?php echo form_error('txtPayrollDate') ?></div>
						</div>
						<div class="input-group">
							<input type="date" class="form-control input-sm" name="txtPayrollDate" value="<?php echo set_value('txtPayrollDate'); ?>">
						</div>
			    	</div>
			    	<div class="col-sm-2">
			    		<div class="row">
							<label for="txtStartDate" class="control-label">Start Date: </label>
							<div class="col-sm-2 error"><?php echo form_error('txtStartDate') ?></div>
						</div>
						<div class="input-group">
							<input type="date" class="form-control input-sm" name="txtStartDate" value="<?php echo set_value('txtStartDate'); ?>">
						</div>
			    	</div>
					<div class="col-sm-2">
			    		<div class="row">
							<label for="txtEndDate" class="control-label">End Date: </label>
							<div class="col-sm-2 error"><?php echo form_error('txtEndDate') ?></div>
						</div>
						<div class="input-group">
							<input type="date" class="form-control input-sm" name="txtEndDate" value="<?php echo set_value('txtEndDate'); ?>">
						</div>
			    	</div>
					<div class="col-sm-6">
						<div class="signupButtons text-right">
							<input type="submit" class="btn btn-success btn-lg" name="btnSubmit" value="View">
						</div>
					</div>
			    </div>		    
			</div>
			<div class="panel-body">
				<div class="col-md-12 text-center">
					<table class="table table-striped table-hover table-bordered table-condensed ">				
						<thead >
							<th class="text-center">Include</th>
							<th class="col-md-1 text-center">Emp ID</th>
							<th class="col-md-3 text-center">Employee Name</th>
							<th class="col-md-2 text-center">Basic Salary</th>
							<th class="col-md-2 text-center">Days Absent</th>
							<th class="col-md-2 text-center">Gross Pay</th>
							<th class="col-md-2 text-center">Net Pay</th>
						</thead>
						<input type="hidden" name="hidTotalEmp" value="<?php echo count($payslips); ?>" />
						<?php $ctr=1; foreach($payslips as $row){ ?>
						<tr>
							<td class="text-center">
								<input type="checkbox" name="chkEmp<?php echo $ctr; ?>" checked />
							</td>
							<td class="col-md-1 text-center">
								<input type="hidden" name="hidID<?php echo $ctr; ?>" value="<?php echo $row["employee"]->emp_id; ?>" />
								<?php echo $row["employee"]->emp_id; ?>
							</td>
							<td class="col-md-3">
								<?php echo $row["employee"]->last_name . ", " . $row["employee"]->first_name . " " . $row["employee"]->middle_name; ?>
							</td>
							<td class="col-md-2 text-right">
							
								<input type="hidden" name="hidMonthlyRate<?php echo $ctr; ?>" value="<?php echo $row["employee"]->salary; ?>" />
								<input type="hidden" name="hidBasicSalary<?php echo $ctr; ?>" value="<?php echo $row["cutoffsalary"]; ?>" />
								<input type="hidden" name="hidTotalTax<?php echo $ctr; ?>" value="<?php echo $row["total_tax"]; ?>" />
								<input type="hidden" name="hidTotalAllowance<?php echo $ctr; ?>" value="<?php echo $row["total_allowance"]; ?>" />
								<input type="hidden" name="hidTotalOvertime<?php echo $ctr; ?>" value="<?php echo $row["total_overtime"]; ?>" />
								<input type="hidden" name="hidTotalTardiness<?php echo $ctr; ?>" value="<?php echo $row["total_tardiness"]; ?>" />
								<input type="hidden" name="hidTotalAbsent<?php echo $ctr; ?>" value="<?php echo $row["total_absent"]; ?>" />
								<input type="hidden" name="hidTotalAbsentAmount<?php echo $ctr; ?>" value="<?php echo $row["total_absent_amount"]; ?>" />
								<input type="hidden" name="hidGrossIncome<?php echo $ctr; ?>" value="<?php echo $row["gross_income"]; ?>" />
								<input type="hidden" name="hidNetIncome<?php echo $ctr; ?>" value="<?php echo $row["net_income"]; ?>" />
								
								<?php echo number_format($row["cutoffsalary"], 2, ".", ","); ?>
							</td>
							<td class="col-md-2 text-right">
								<?php echo number_format($row["total_absent"], 2, ".", ","); ?>
							</td>
							<td class="col-md-2 text-right">
								<?php echo number_format($row["gross_income"], 2, ".", ","); ?>
							</td>
							<td class="col-md-2 text-right">
								<?php echo number_format($row["net_income"], 2, ".", ","); ?>
							</td>
						</tr>
						<?php $ctr++; } ?>
					</table>
					<input type="hidden" name="hidPayDate" value="<?php echo set_value('txtPayrollDate'); ?>" />
					<input type="hidden" name="hidPayStart" value="<?php echo set_value('txtStartDate'); ?>" />
					<input type="hidden" name="hidPayEnd" value="<?php echo set_value('txtEndDate'); ?>" />
					<input type="submit" class="btn btn-success btn-lg" name="btnGenerate" value="Generate">
				</div>
			</div>	
			</form>
		</div>
	</div>
</div>
