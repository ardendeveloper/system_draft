<div class="content-wrapper">
    <ol class="breadcrumb">
        <li><a href="<?php echo base_url();?>ems/dashboard" class="btn btn-default"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class='active'>Reports</li>
    </ol>
    <div class="container-fluid">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-sm-8">
                        <h1 class="panel-title big">Employees</h1>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <form action="<?php echo base_url();?>reports/employees_list" role="form" method="post">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-header pull-left">
                            <h4>Filter By:</h4>
                        </div>
                        <div class="pull-right">
                            <input type="submit" name="btnFilter" value="Filter" class="btn btn-success btn-lg">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label for="status">Status:</label>
                            <select name="txtStatus" id="status" class="form-control">
                            <option value="">---</option>
                                <option value="Active" <?php if($this->input->post('txtStatus')=='Active') { echo "selected";}?> >Active</option>
                                <option value="Inactive" <?php if($this->input->post('txtStatus')=='Inactive') { echo "selected";}?> >Inactive</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label for="emp_name">Job Title:</label>
                            <select name="txtJobTitle" id="emp_name" class="form-control">
                                <option value="">All Job Titles</option>
                                <?php foreach ($job_titles as $row){ 
                                    echo "<option value='$row->job_title_name'>$row->job_title_name</option>";
                                } ?>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label for="emp_name">Employment Type:</label>
                            <select name="txtEmploymentType" id="emp_name" class="form-control">
                                <option value="">All Employment Types</option>
                                <?php foreach ($employment_type as $row){ 
                                    echo "<option value='$row->employment_type'>$row->employment_type </option>";
                                } ?>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label for="emp_name">Department:</label>
                            <select name="txtDepartment" id="emp_name" class="form-control">
                                <option value="">All Departments</option>
                                <?php foreach ($departments as $row){ 
                                    echo "<option value='$row->department_name'>$row->department_name</option>";
                                } ?>
                            </select>
                        </div>
                    </div>
                </div><br>
                </form>
                <?php if ($this->input->post('btnFilter')) { ?>
                    <table class="table table-striped table-hover table-bordered">
                    <thead>
                        <th class="table-head">Emp. ID</th>
                        <th class="table-head">Employee Name</th>
                        <th class="table-head">Job Title</th>
                        <th class="table-head">Department</th>
                        <th class="table-head">Employment Type</th>
                        <th class="table-head">Status</th>
                        <th class="table-head">Date Hired</th>
                    </thead>

                    <?php
                    if ($report) {
                        foreach ($report as $record) { 
                    ?>
                    <tr>
                        <td align="center">
                            <?php echo $record->emp_id; ?>
                        </td>
                        <td>
                            <a href="<?php echo base_url('ems/view_details'); ?>?emp_id=<?php echo $record->emp_id; ?>">
                                <?php echo $record->first_name.' '.$record->middle_name.' '.$record->last_name; ?>
                            </a>
                        </td>
                        <td>
                            <?php echo $record->job_title_name; ?>
                        </td>
                        <td>
                            <?php echo $record->department_name; ?>
                        </td>
                        <td>
                            <?php echo $record->employment_type; ?>
                        </td>
                        <td class="text-center">
                            <?php if ($record->status == 'Active'){
                                echo "<label class='label label-success'>$record->status</label>"; 
                            } else {
                                echo "<label class='label label-danger'>$record->status</label>";
                            }
                            ?>
                        </td>
                        <td align="center">
                            <?php echo $record->start_date; ?>
                        </td>
                    </tr>
                    <?php  }
                        }  else {
                            echo "0 record found.";
                        }
                    ?>
                </table>
                <?php } ?>
            </div>
        </div>
    </div>
</div>
