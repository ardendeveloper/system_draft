<div class="content-wrapper">
    <ol class="breadcrumb">
        <li><a href="<?php echo base_url(); ?>admin/dashboard" class="btn btn-default"><i class="fa fa-dashboard"></i>
                Dashboard</a></li>
    </ol>
    <div class="container-fluid">
        <div class="box box-info box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">Admin Dashboard</h3>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-lg-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-aqua">
                            <div class="inner">
                                <h3><?php echo $total_employee; ?></h3>

                                <p>Total Employees</p>
                            </div>
                            <div class="icon">
                                <i class="fa fa-user"></i>
                            </div>
                            <a href="<?php echo base_url(); ?>ems/employees" class="small-box-footer">View Employees
                                <i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>

                    <!-- ./col -->
                    <div class="col-lg-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-green">
                            <div class="inner">
                                <h3><?php echo $total_projects; ?></h3>

                                <p>Active Projects</p>
                            </div>
                            <div class="icon">
                                <i class="fa fa-clock-o"></i>
                            </div>
                            <a href="<?php echo base_url('ams/view_projects'); ?>" class="small-box-footer">View Projects <i
                                    class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-yellow">
                            <div class="inner">
                                <h3><?php echo $total_asset; ?></h3>

                                <p>Total Assets</p>
                            </div>
                            <div class="icon">
                                <i class="fa fa-cubes"></i>
                            </div>
                            <a href="<?php echo base_url('ams/view_assets'); ?>" class="small-box-footer">View Assets <i
                                    class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-red">
                            <div class="inner">
                                <h3>10</h3>

                                <p>Upcoming Leaves</p>
                            </div>
                            <div class="icon">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <a href="<?php echo base_url('ems/leaves_table'); ?>" class="small-box-footer">View Leaves <i
                                    class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                </div>
                <!-- /.row -->
            </div>
        </div>
    </div>

</div>