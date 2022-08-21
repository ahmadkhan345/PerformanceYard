class employeeModel{
  String name;
  String department;
  int emp_id;
  double last_evaluation;
  double satisfaction_level;
  int number_project;
  double average_monthly_hours;
  double time_spend_company;

  employeeModel(this.name, this.department, this.emp_id,this.last_evaluation,this.average_monthly_hours,this.satisfaction_level,this.number_project,this.time_spend_company);

  Map<String, dynamic> toJson() => {
    'name': name,
    'department':department,
    'emp_id':emp_id,
    'last_evaluation':last_evaluation,
    'average_monthly_hours':average_monthly_hours,
    'satisfaction_level':satisfaction_level,
    'number_project':number_project,
    'time_spend_company':time_spend_company,
  };
}