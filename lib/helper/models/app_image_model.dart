class AppImageModel {
  String? serviceForm;
  String? serviceCsc;
  String? serviceLibrary;
  String? serviceOtherService;
  String? formAll;
  String? formInstitution;
  String? formLastDate;
  String? serviceFormDownloaded;
  String? serviceCscDownloaded;
  String? serviceLibraryDownloaded;
  String? serviceOtherServiceDownloaded;
  String? formAllDownloaded;
  String? formInstitutionDownloaded;
  String? formLastDateDownloaded;

  AppImageModel({
    this.serviceForm,
    this.serviceCsc,
    this.serviceLibrary,
    this.serviceOtherService,
    this.formAll,
    this.formInstitution,
    this.formLastDate,
    this.formAllDownloaded,
    this.formInstitutionDownloaded,
    this.formLastDateDownloaded,
    this.serviceCscDownloaded,
    this.serviceFormDownloaded,
    this.serviceLibraryDownloaded,
    this.serviceOtherServiceDownloaded,
  });

  AppImageModel.fromJson(Map<String, dynamic> json) {
    serviceForm = json['service_form'];
    serviceCsc = json['service_csc'];
    serviceLibrary = json['service_library'];
    serviceOtherService = json['service_other_service'];
    formAll = json['form_all'];
    formInstitution = json['form_institution'];
    formLastDate = json['form_last_date'];
    serviceFormDownloaded = json['service_form_download'];
    serviceCscDownloaded = json['service_csc_download'];
    serviceLibraryDownloaded = json['service_library_download'];
    serviceOtherServiceDownloaded = json['service_other_service_download'];
    formAllDownloaded = json['form_all_download'];
    formInstitutionDownloaded = json['form_institution_download'];
    formLastDateDownloaded = json['form_last_date_download'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_form'] = serviceForm;
    data['service_csc'] = serviceCsc;
    data['service_library'] = serviceLibrary;
    data['service_other_service'] = serviceOtherService;
    data['form_all'] = formAll;
    data['form_institution'] = formInstitution;
    data['form_last_date'] = formLastDate;
    data['service_form_download'] = serviceFormDownloaded;
    data['service_csc_download'] = serviceCscDownloaded;
    data['service_library_download'] = serviceLibraryDownloaded;
    data['service_other_service_download'] = serviceOtherServiceDownloaded;
    data['form_all_download'] = formAllDownloaded;
    data['form_institution_download'] = formInstitutionDownloaded;
    data['form_last_date_download'] = formLastDateDownloaded;
    return data;
  }
}
