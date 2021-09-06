class GuestInfo{
  String? sID;
  String? sFirstName;
  String? sLastName;
  String? sEmail;

  GuestInfo({required this.sID ,required this.sFirstName, required this.sLastName, this.sEmail});
  GuestInfo.newEmptyGuest();
}