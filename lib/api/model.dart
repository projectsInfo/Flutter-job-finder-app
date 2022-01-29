class Posts {
  final int id;
  //final List <String> something;
  final String code;
  final String title;
  final String job_description;
  final int company_id;

  Posts({required this.id,
    //required this.user_id,
    required this.code, required this.title , required this.job_description , required this.company_id ,});

  factory Posts.formJson(Map <dynamic, dynamic> json){

    return new Posts(
      id: json['id'],
      code: json['code'],
      title: json['title'],
      job_description: json['job_description'],
      company_id: json['company_id'],
    );
  }
}