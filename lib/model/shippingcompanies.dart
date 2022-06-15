class CompanyShipping{
  final String? id,url,img,title,location,phone;

  CompanyShipping(
      {this.id, this.url, this.img, this.title, this.location, this.phone});

  factory CompanyShipping.fromJson(Map<String, dynamic> json) => CompanyShipping(
    id: json["id"],
    url: json["premium"],
    img: json["URLLink"],
    title: json["Name"],
    location: json["Name"],
    phone: json["Name"],
  );

  static List<CompanyShipping> company=[
    CompanyShipping(url: "https://translate.google.com",phone: "0231435132",id: "1",title: "أرامكس",location: "السعودية, جدة",img: "https://static.remove.bg/remove-bg-web/eb1bb48845c5007c3ec8d72ce7972fc8b76733b1/assets/start-1abfb4fe2980eabfbbaaa4365a0692539f7cd2725f324f904565a9a744f8e214.jpg",),
    CompanyShipping(url: "https://www.youtube.com",phone: "0231435132",id: "2",title: "فيدكس",location: "السعودية, جدة",img: "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search/jcr_content/main-pars/image/visual-reverse-image-search-v2_intro.jpg",),
  ];
}