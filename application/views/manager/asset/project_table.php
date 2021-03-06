<div class="content-wrapper">
	<ol class="breadcrumb">
		<li><a href="<?php echo base_url();?>ams/dashboard" class="btn btn-default"><i class="fa fa-dashboard"></i> Dashboard</a></li>
		<li class="active"><i class="fa fa-cogs"></i> Projects </li>
	</ol>
	<div class="container-fluid">
		<div class="box box-warning box-solid">
			<div class="box-header with-border">
				<h1 class="box-title big">Projects Table</h1>
			</div>
			<div class="box-body">
				<div class="pull-left addButton">
					<a href="<?php echo base_url();?>ams/add_project">
						<button class="btn btn-success"><i class="fa fa-plus"></i> Add New Project </button>
					</a>
					<a href="<?php echo base_url();?>ams/add_materials">
						<buttom class="btn btn-info"><i class="fa fa-plus"></i> Add New Materials </buttom>
					</a>
				</div>
				<div class="clearfix"></div>
				<table id="dynamicTable" class="table table-striped table-hover table-bordered centered">
					<thead>
						<th class="text-center">ID</th>
						<th class="text-center">Project Name</th>
						<th class="text-center">Client Name</th>
						<th class="text-center">Project Cost</th>
						<th class="text-center">Starting Date</th>
						<th class="text-center">Ending Date</th>
						<th class="text-center">Manage</th>
					</thead>
					<?php foreach ($record as $row) { ?>
						<tr>
							<td class="text-center">
								<?php echo $row->project_id; ?>
							</td>
							<td>
								<?php echo $row->project_name; ?>
							</td>
							<td>
								<?php echo $row->client; ?>
							</td>
							<td class="text-center">
								<?php echo number_format($row->total_expense,2); ?>
							</td>
							<td class="text-center">
								<?php echo date_format($row->starting_date,'M d, Y'); ?>
							</td>
							<td class="text-center">
								<?php echo date_format($row->ending_date,'M d, Y'); ?>
							</td>
							<td class="text-center">
								<a href="<?php echo base_url(); ?>ams/view_materials?project_id=<?php echo $row->project_id; ?>">
									<button class="btn btn-primary btn-xs" data-toggle="tooltip" data-placement="top" title="View Materials">
										<i class="fa fa-search"></i>
									</button>
								</a>
								<!-- <a href="<?php echo base_url(); ?>ams/add_project_materials?project_id=<?php echo $row->project_id; ?>">
									<button class="btn btn-success btn-xs" data-toggle="tooltip" data-placement="top" title="Add Materials">
										<i class="fa fa-plus"></i>
									</button>
								</a> -->
							</td>
						</tr>
						<?php } ?>
				</table>
			</div>
		</div>
	</div>
</div>
