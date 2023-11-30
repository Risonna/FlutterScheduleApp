abstract class IAdminTeacherSender{
  Future<List<String>> requestAdminsTeachers();
  Future<void> sendAdminTeacher(String username, String endpoint, String token);

}