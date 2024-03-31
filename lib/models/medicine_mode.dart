class Medicine {
  final String name;
  final String about;
  final String formula;
  final String image;
  String type;
  double rating;
  double goodReviews;
  double totalScore;
  double satisfaction;
  final String constraints;
  Medicine(
      {required this.about,
      required this.formula,
      required this.image,
      required this.constraints,
      required this.rating,
      required this.goodReviews,
      required this.totalScore,
      required this.satisfaction,
      required this.type,
      required this.name});
}

List<Medicine> medList = [
  Medicine(
    about:
        '''Paracetamol is a medicine used to treat mild to moderate pain. Paracetamol can also be used to treat fever (high temperature). It's dangerous to take more than the recommended dose of paracetamol. Paracetamol overdose can damage your liver and cause death.''',
    formula: 'Hoyrdoxyl Benzyl',
    image: 'assets/images/med1.png',
    constraints: '₹ 15 / 10 Tablets',
    name: 'Paracetamol',
    type: "Pain Killer",
    rating: 4.5,
    goodReviews: 93.2,
    totalScore: 72.2,
    satisfaction: 89.2,
  ),
  Medicine(
    about:
        "This medication is used to treat the symptoms of too much stomach acid such as stomach upset, heartburn, and acid indigestion. It is also used to relieve symptoms of extra gas such as belching, bloating, and feelings of pressure/discomfort in the stomach/gut. Simethicone helps break up gas bubbles in the gut.",
    formula: 'Aluminium Hydroxide',
    image: 'assets/images/med2.png',
    constraints: '₹ 75 / 100 ml ',
    name: 'Maalox Plus',
    type: "Antacid",
    rating: 3.5,
    goodReviews: 79.2,
    totalScore: 93.2,
    satisfaction: 85.2,
  ),
  Medicine(
    about:
        '''Sumo Cold tablet is used to relieve the symptoms of a common cold like a blocked nose, fever, chills and breathing difficulty due to sinus inflammation and associated pain. It also helps relieve allergic symptoms like runny nose, watery eyes and sneezing.''',
    formula: 'Phenylephirne Hydrochloride',
    image: 'assets/images/med3.png',
    constraints: '₹ 35 / 10 Tablets',
    name: 'Sumocold Tablets',
    type: "Antipyratic",
    rating: 3.8,
    goodReviews: 88.2,
    totalScore: 92.7,
    satisfaction: 78.2,
  ),
  Medicine(
    about:
        '''Quadriderm RF cream is used for the treatment of various skin infections caused by bacteria, fungi, or mixed infections. It helps to manage symptoms like scratching, red sores, itching, dermatitis, inflammation, and rashes when associated with skin infections.''',
    formula: 'Hydroxyamine',
    image: 'assets/images/med4.png',
    constraints: '₹ 64 / 15 g',
    name: 'Quadriderm',
    type: "Anti-bacterial, Anti-fungal",
    rating: 4.1,
    goodReviews: 64.2,
    totalScore: 84.2,
    satisfaction: 89.2,
  ),
  Medicine(
    about:
        '''Dynapar Gel is a pain-relief gel formulated with diclofenac, virgin linseed oil, methyl salicylate, and menthol, which can help provide relief from pain, swelling, and inflammation caused due to low back pain, should pain, neck stiffness, joint pain, and sports injury.''',
    formula: 'Alpha Linolinic Acid',
    image: 'assets/images/med5.png',
    constraints: '₹ 134 / 50 g',
    name: 'Dynapar Gel',
    type: "Anti-inflamatory",
    rating: 3.5,
    goodReviews: 89.2,
    totalScore: 86.2,
    satisfaction: 90.2,
  ),
  Medicine(
    about:
        "Koflet is used to cure both productive and dry coughs. The mucolytic and expectorant properties reduce the viscosity of bronchial secretions and facilitate expectoration. Koflet's cough suppressant action reduces bronchial mucosal irritation and related bronchospasms.",
    formula: 'Dextromethorphan Hydrobromide ',
    image: 'assets/images/med6.png',
    constraints: '₹ 78 / 100 ml',
    name: 'Koflet',
    type: "Cough Syrup",
    rating: 4.6,
    goodReviews: 87.2,
    totalScore: 72.2,
    satisfaction: 86.9,
  ),
  Medicine(
    about:
        "This combination product is used to treat minor wounds (such as cuts, scrapes, burns) and to help prevent or treat mild skin infections. Minor skin infections and wounds usually heal without treatment, but some minor skin wounds may heal faster when an antibiotic is applied to the affected area.",
    formula: 'Cetrimide',
    image: 'assets/images/med7.png',
    constraints: '₹ 15/ 10 Tablets',
    name: 'Betadine',
    type: "Antisceptic",
    rating: 3.5,
    goodReviews: 93.2,
    totalScore: 72.2,
    satisfaction: 89.2,
  ),
];
