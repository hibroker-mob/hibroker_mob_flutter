import 'package:flutter/material.dart';
import 'package:hibroker/components/DashboardDrawer.dart';
import 'package:hibroker/pages/Call_Log_Recording/CallLogs.dart';
import 'package:hibroker/pages/Call_Log_Recording/Records.dart';
import 'package:hibroker/pages/Contact/AllContacts/AdvanceSearch.dart';
import 'package:hibroker/pages/Contact/AllContacts/ContactDetails.dart';
import 'package:hibroker/pages/Contact/AllContacts/Content.dart';
import 'package:hibroker/pages/Contact/AllContacts/CreateGroup.dart';
import 'package:hibroker/pages/Contact/AllContacts/Export.dart';
import 'package:hibroker/pages/Contact/AllContacts/Import.dart';
import 'package:hibroker/pages/Contact/AllContacts/MyContacts.dart';
import 'package:hibroker/pages/Contact/AllContacts/SendEmail.dart';
import 'package:hibroker/pages/Contact/AllContacts/SendSMS.dart';
import 'package:hibroker/pages/Contact/AllContacts/SendWhatsApp.dart';
import 'package:hibroker/pages/Contact/AllContacts/Transfer.dart';
import 'package:hibroker/pages/Contact/ColdCalls/ColdAdvanceSearch.dart';
import 'package:hibroker/pages/Contact/ColdCalls/ColdCalls.dart';
import 'package:hibroker/pages/Contact/ColdCalls/ColdCreateGroup.dart';
import 'package:hibroker/pages/Contact/ColdCalls/ColdExport.dart';
import 'package:hibroker/pages/Contact/ColdCalls/ColdImport.dart';
import 'package:hibroker/pages/Contact/ColdCalls/ColdTransfer.dart';
import 'package:hibroker/pages/Contact/CreateContact/CreateContact.dart';
import 'package:hibroker/pages/Contact/CreateContact/PersonalInfo.dart';
import 'package:hibroker/pages/DashboardHome.dart';
import 'package:hibroker/pages/Lead/CreateLead/CreateLead.dart';
import 'package:hibroker/pages/LoginMail.dart';
import 'package:hibroker/pages/LoginMobile.dart';
import 'package:hibroker/pages/OTPPassword.dart';

class AppRoutes {
  static String loginMail = '/loginMail';
  static String loginMobile = '/loginMobile';
  static String otpPassword = '/otpPassword';
  static String dashboardDrawer = '/dashboardDrawer';
  static String dashboardHome = '/dashboardHome';
  static String createContact = '/createContact';
  static String allContact = '/allContact';
  static String exportContact = '/exportContact';
  static String importContact = '/importContact';
  static String advanceSearch = '/advanceSearch';
  static String createGroup = '/createGroup';
  static String transfer = '/transfer';
  static String contentPage = '/contentPage';
  static String callLogs = '/callLogs';
  static String recordings = '/recordings';
  static String coldCalls = '/coldCalls';
  static String coldExport = '/coldExport';
  static String coldImport = '/coldImport';
  static String coldAdvanceSearch = '/coldAdvanceSearch';
  static String coldCreateGroup = '/coldCreateGroup';
  static String coldTransfer = '/coldTransfer';
  static String contactDetails = '/contactDetails';
  static String personalInfo = '/personalInfo';
  static String sendEmail = '/sendEmail';
  static String sendSMS = '/sendSMS';
  static String sendWhatsApp = '/sendWhatsApp';
  static String createLead = '/createLead';

  static Map<String, WidgetBuilder> define() {
    return {
      loginMail: (context) => const LoginMail(),
      loginMobile: (context) => const LoginMobile(),
      otpPassword: (context) => const OTPPassword(),
      dashboardDrawer: (context) => const DashboardDrawer(),
      dashboardHome: (context) => const DashboardHome(),
      createContact: (context) => const CreateContact(),
      allContact: (context) => const MyContacts(),
      exportContact: (context) => const ExportContact(),
      importContact: (context) => const ImportContact(),
      advanceSearch: (context) => const AdvanceSchedule(),
      createGroup: (context) => const CreateGroup(),
      transfer: (context) => const Transfer(),
      contentPage: (context) => const ContentPage(),
      callLogs: (context) => const CallLogs(),
      recordings: (context) => const Recordings(),
      coldCalls: (context) => const ColdCalls(),
      coldExport: (context) => const ColdExportContact(),
      coldImport: (context) => const ColdImportContact(),
      coldAdvanceSearch: (context) => const ColdAdvanceSearch(),
      coldCreateGroup: (context) => const ColdCreateGroup(),
      coldTransfer: (context) => const ColdTransfer(),
      contactDetails: (context) => const ContactDetails(),
      personalInfo: (context) => const PersonalInfo(),
      sendEmail: (context) => const SendEmail(),
      sendSMS: (context) => const SendSMS(),
      sendWhatsApp: (context) => const SendWhatsApp(),
      createLead: (context) => const Createlead(),
    };
  }
}
