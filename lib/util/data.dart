const areas = [
  '1영역',
  '2영역',
  '3영역',
  '4영역',
  '5영역',
  '6영역',
  '7영역',
  '8영역',
  '글컬',
  '소양',
  '융합',
  '공통과목'
];

const difficulty = ['상', '중', '하'];

const lectures = [
  {'area': '1영역', 'lecture': 'SF문학과과학적상상력', 'credit': 3, 'professor': '전지니'},
  {'area': '융합', 'lecture': 'UCC제작과비평', 'credit': 3, 'professor': '김삼력'},
  {'area': '4영역', 'lecture': '결혼과가족', 'credit': 3, 'professor': '박관영'},
  {'area': '6영역', 'lecture': '경영학콘서트', 'credit': 3, 'professor': '정진'},
  {'area': '6영역', 'lecture': '경영학콘서트', 'credit': 3, 'professor': '김동민'},
  {'area': '소양', 'lecture': '골프', 'credit': 1, 'professor': '이인엽'},
  {'area': '소양', 'lecture': '골프', 'credit': 1, 'professor': '지준철'},
  {'area': '소양', 'lecture': '골프', 'credit': 1, 'professor': '정지윤'},
  {'area': '융합', 'lecture': '공학과프로그래밍언어', 'credit': 3, 'professor': '신정호'},
  {'area': '3영역', 'lecture': '공학윤리', 'credit': 3, 'professor': '임건태'},
  {'area': '3영역', 'lecture': '공학윤리', 'credit': 3, 'professor': '황호식'},
  {'area': '3영역', 'lecture': '공학윤리', 'credit': 3, 'professor': '소병일'},
  {'area': '7영역', 'lecture': '과학기술과문명', 'credit': 3, 'professor': '오기영'},
  {'area': '5영역', 'lecture': '과학기술문서작성과발표', 'credit': 3, 'professor': '김정훈'},
  {'area': '5영역', 'lecture': '과학기술문서작성과발표', 'credit': 3, 'professor': '정명문'},
  {'area': '3영역', 'lecture': '교육봉사활동', 'credit': 2, 'professor': '강창동'},
  {'area': '3영역', 'lecture': '교육사회', 'credit': 2, 'professor': '강창동'},
  {'area': '3영역', 'lecture': '교육심리', 'credit': 2, 'professor': '정미경'},
  {'area': '3영역', 'lecture': '교육학의이해', 'credit': 3, 'professor': '박미연'},
  {'area': '3영역', 'lecture': '교육행정및교육경영', 'credit': 2, 'professor': '이유정'},
  {'area': '3영역', 'lecture': '교직실무', 'credit': 2, 'professor': '이유정'},
  {'area': '소양', 'lecture': '국제협력론', 'credit': 3, 'professor': '김희숙'},
  {'area': '6영역', 'lecture': '글로벌시대의국제관계', 'credit': 3, 'professor': '김희숙'},
  {'area': '6영역', 'lecture': '기술경영', 'credit': 3, 'professor': '김대중'},
  {'area': '6영역', 'lecture': '기술경영', 'credit': 3, 'professor': '안재근'},
  {'area': '6영역', 'lecture': '기술경영', 'credit': 3, 'professor': '신세윤'},
  {'area': '6영역', 'lecture': '기술경영', 'credit': 3, 'professor': '박재희'},
  {'area': '6영역', 'lecture': '기술경영', 'credit': 3, 'professor': '김진'},
  {'area': '6영역', 'lecture': '기술경영', 'credit': 3, 'professor': '박현식'},
  {'area': '소양', 'lecture': '기업가정신과창업', 'credit': 3, 'professor': '강무희'},
  {'area': '소양', 'lecture': '기업과 사회와 노동', 'credit': 3, 'professor': '류호상'},
  {'area': '5영역', 'lecture': '논리와비판적사고', 'credit': 3, 'professor': '김영래'},
  {'area': '소양', 'lecture': '농구', 'credit': 1, 'professor': '유정인'},
  {'area': '4영역', 'lecture': '다문화교육의이해', 'credit': 3, 'professor': '오덕열'},
  {'area': '4영역', 'lecture': '다문화교육의이해', 'credit': 3, 'professor': '서정기'},
  {'area': '3영역', 'lecture': '다문화사회와사회정책', 'credit': 3, 'professor': '송현희'},
  {'area': '3영역', 'lecture': '대중문화의이해', 'credit': 3, 'professor': '전지니'},
  {'area': '공통과목', 'lecture': '대학생활과진로설정', 'credit': 1, 'professor': '대학일자리센터'},
  {'area': '7영역', 'lecture': '대학수학', 'credit': 3, 'professor': '미정'},
  {'area': '1영역', 'lecture': '동서양고전과세상읽기', 'credit': 3, 'professor': '김찬기'},
  {'area': '1영역', 'lecture': '동서양신화와문화콘텐츠', 'credit': 3, 'professor': '미정'},
  {'area': '3영역', 'lecture': '동양사상으로의초대', 'credit': 3, 'professor': '박승원'},
  {'area': '3영역', 'lecture': '동양사상으로의초대', 'credit': 3, 'professor': '황호식'},
  {'area': '4영역', 'lecture': '동양역사와문화', 'credit': 3, 'professor': '문상명'},
  {'area': '소양', 'lecture': '레크레이션', 'credit': 1, 'professor': '문경영'},
  {'area': '소양', 'lecture': '레크레이션', 'credit': 1, 'professor': '김경렬'},
  {'area': '소양', 'lecture': '레크레이션', 'credit': 1, 'professor': '이윤일'},
  {'area': '소양', 'lecture': '레크레이션', 'credit': 1, 'professor': '황용묵'},
  {'area': '소양', 'lecture': '레크레이션', 'credit': 1, 'professor': '황인선'},
  {'area': '소양', 'lecture': '리더십의이해', 'credit': 3, 'professor': '미정'},
  {'area': '6영역', 'lecture': '마케팅이해하기', 'credit': 3, 'professor': '한승희'},
  {'area': '공통과목', 'lecture': '말하기와글쓰기', 'credit': 3, 'professor': '전지니'},
  {'area': '공통과목', 'lecture': '말하기와글쓰기', 'credit': 3, 'professor': '이은선'},
  {'area': '공통과목', 'lecture': '말하기와글쓰기', 'credit': 3, 'professor': '조미경'},
  {'area': '공통과목', 'lecture': '말하기와글쓰기', 'credit': 3, 'professor': '미정'},
  {'area': '공통과목', 'lecture': '말하기와글쓰기', 'credit': 3, 'professor': '김지녀'},
  {'area': '공통과목', 'lecture': '말하기와글쓰기', 'credit': 3, 'professor': '마상룡'},
  {'area': '소양', 'lecture': '면접과프레젠테이션', 'credit': 2, 'professor': '박선환'},
  {'area': '6영역', 'lecture': '모바일혁명이야기', 'credit': 3, 'professor': '김현주'},
  {'area': '8영역', 'lecture': '몸과생명', 'credit': 3, 'professor': '이양진'},
  {'area': '1영역', 'lecture': '문학과영상', 'credit': 3, 'professor': '김희주'},
  {'area': '1영역', 'lecture': '문학과영상', 'credit': 3, 'professor': '서미진'},
  {'area': '1영역', 'lecture': '문학과영상', 'credit': 3, 'professor': '미정'},
  {'area': '1영역', 'lecture': '문학의이해', 'credit': 3, 'professor': '유지현'},
  {'area': '3영역', 'lecture': '미디어로보는세계종교', 'credit': 3, 'professor': '손원영'},
  {'area': '5영역', 'lecture': '미디어로소통하기', 'credit': 3, 'professor': '김삼력'},
  {'area': '1영역', 'lecture': '미술의감상과비평', 'credit': 3, 'professor': '오유진'},
  {'area': '7영역', 'lecture': '미적분학1', 'credit': 3, 'professor': '유재하'},
  {'area': '7영역', 'lecture': '미적분학1', 'credit': 3, 'professor': '이윤진'},
  {'area': '7영역', 'lecture': '미적분학2', 'credit': 3, 'professor': '백승재'},
  {'area': '7영역', 'lecture': '미적분학2', 'credit': 3, 'professor': '이윤진'},
  {'area': '7영역', 'lecture': '미적분학2', 'credit': 3, 'professor': '이택기'},
  {'area': '7영역', 'lecture': '미적분학2', 'credit': 3, 'professor': '최명준'},
  {'area': '7영역', 'lecture': '미적분학2', 'credit': 3, 'professor': '오광석'},
  {'area': '7영역', 'lecture': '미적분학2', 'credit': 3, 'professor': '이종환'},
  {'area': '7영역', 'lecture': '미적분학2', 'credit': 3, 'professor': '유현재'},
  {'area': '7영역', 'lecture': '미적분학2', 'credit': 3, 'professor': '유재하'},
  {'area': '7영역', 'lecture': '미적분학2', 'credit': 3, 'professor': '채명주'},
  {'area': '소양', 'lecture': '배드민턴', 'credit': 1, 'professor': '윤완수'},
  {'area': '4영역', 'lecture': '법과문화', 'credit': 3, 'professor': '한지혜'},
  {'area': '소양', 'lecture': '봉사활동', 'credit': 1, 'professor': '김한중'},
  {'area': '2영역', 'lecture': '부모교육론', 'credit': 3, 'professor': '박효정'},
  {'area': '6영역', 'lecture': '사물인터넷의세상', 'credit': 3, 'professor': '최미경'},
  {'area': '3영역', 'lecture': '삶과철학', 'credit': 3, 'professor': '임건태'},
  {'area': '3영역', 'lecture': '삶과철학', 'credit': 3, 'professor': '이상문'},
  {'area': '7영역', 'lecture': '생명과학', 'credit': 3, 'professor': '성지연'},
  {'area': '7영역', 'lecture': '생명의기원과진화', 'credit': 3, 'professor': '이양진'},
  {'area': '2영역', 'lecture': '생활법률', 'credit': 3, 'professor': '한지혜'},
  {'area': '2영역', 'lecture': '생활법률', 'credit': 3, 'professor': '금종례'},
  {'area': '2영역', 'lecture': '생활속의상담심리', 'credit': 3, 'professor': '조영주'},
  {'area': '7영역', 'lecture': '생활속의수학', 'credit': 3, 'professor': '박정주'},
  {'area': '7영역', 'lecture': '생활속의화학', 'credit': 3, 'professor': '한기종'},
  {'area': '8영역', 'lecture': '생활원예', 'credit': 3, 'professor': '장정은'},
  {'area': '5영역', 'lecture': '생활한자와한문', 'credit': 3, 'professor': '한정미'},
  {'area': '4영역', 'lecture': '서양역사와문화', 'credit': 3, 'professor': '이종훈'},
  {'area': '7영역', 'lecture': '선형대수학', 'credit': 3, 'professor': '이은경'},
  {'area': '7영역', 'lecture': '선형대수학', 'credit': 3, 'professor': '김한정'},
  {'area': '7영역', 'lecture': '선형대수학', 'credit': 3, 'professor': '박상돈'},
  {'area': '1영역', 'lecture': '세계의민속음악', 'credit': 3, 'professor': '조효종'},
  {'area': '1영역', 'lecture': '세계의민속음악', 'credit': 3, 'professor': '조은경'},
  {'area': '소양', 'lecture': '수상레저', 'credit': 1, 'professor': '김경렬'},
  {'area': '소양', 'lecture': '스키', 'credit': 1, 'professor': '김진훈'},
  {'area': '소양', 'lecture': '스키', 'credit': 1, 'professor': '문경영'},
  {'area': '소양', 'lecture': '스키', 'credit': 1, 'professor': '황인선'},
  {'area': '소양', 'lecture': '스키', 'credit': 1, 'professor': '황용묵'},
  {'area': '소양', 'lecture': '스키', 'credit': 1, 'professor': '양재혁'},
  {'area': '소양', 'lecture': '스키', 'credit': 1, 'professor': '김경렬'},
  {'area': '소양', 'lecture': '스키', 'credit': 1, 'professor': '김희재'},
  {'area': '7영역', 'lecture': '시공간과우주', 'credit': 3, 'professor': '오기영'},
  {'area': '5영역', 'lecture': '시청각영어', 'credit': 3, 'professor': '남은희'},
  {'area': '5영역', 'lecture': '시청각영어', 'credit': 3, 'professor': '최정선'},
  {'area': '공통과목', 'lecture': '실용영어', 'credit': 2, 'professor': '여수연'},
  {'area': '공통과목', 'lecture': '실용영어', 'credit': 2, 'professor': '한정민'},
  {'area': '공통과목', 'lecture': '실용영어', 'credit': 2, 'professor': '박수진'},
  {'area': '공통과목', 'lecture': '실용영어', 'credit': 2, 'professor': '김다정'},
  {'area': '공통과목', 'lecture': '실용영어', 'credit': 2, 'professor': '이효정'},
  {'area': '공통과목', 'lecture': '실용영어', 'credit': 2, 'professor': '이영경'},
  {'area': '3영역', 'lecture': '심리학의이해', 'credit': 3, 'professor': '최영미'},
  {'area': '글컬', 'lecture': '안성맞춤융합교실', 'credit': 3, 'professor': '김원철'},
  {'area': '글컬', 'lecture': '안성지역학의이해', 'credit': 2, 'professor': '서성은'},
  {'area': '6영역', 'lecture': '알기쉬운경제이야기', 'credit': 3, 'professor': '정진'},
  {'area': '5영역', 'lecture': '영문강독', 'credit': 3, 'professor': '박연미'},
  {'area': '5영역', 'lecture': '영어글쓰기', 'credit': 3, 'professor': '류병율'},
  {'area': '5영역', 'lecture': '영어글쓰기', 'credit': 3, 'professor': '류호열'},
  {'area': '공통과목', 'lecture': '영어말하기1', 'credit': 1, 'professor': '린드로스'},
  {'area': '공통과목', 'lecture': '영어말하기1', 'credit': 1, 'professor': '졸도'},
  {'area': '공통과목', 'lecture': '영어말하기1', 'credit': 1, 'professor': '칼튼'},
  {'area': '5영역', 'lecture': '영어말하기2', 'credit': 3, 'professor': '칼튼'},
  {'area': '5영역', 'lecture': '영어말하기2', 'credit': 3, 'professor': '린드로스'},
  {'area': '5영역', 'lecture': '영어말하기2', 'credit': 3, 'professor': '졸도'},
  {'area': '5영역', 'lecture': '영어말하기2', 'credit': 3, 'professor': '안미연'},
  {'area': '3영역', 'lecture': '영화속철학', 'credit': 3, 'professor': '소병일'},
  {'area': '8영역', 'lecture': '웰니스와음식정보', 'credit': 3, 'professor': '김양희'},
  {'area': '8영역', 'lecture': '웰니스와음식정보', 'credit': 3, 'professor': '강근옥'},
  {'area': '1영역', 'lecture': '음악의이해', 'credit': 3, 'professor': '조은경'},
  {'area': '5영역', 'lecture': '이미지와기호', 'credit': 3, 'professor': '김원철'},
  {'area': '7영역', 'lecture': '인간・우주・문명', 'credit': 3, 'professor': '이정민'},
  {'area': '8영역', 'lecture': '인간과식량', 'credit': 3, 'professor': '박영심'},
  {'area': '8영역', 'lecture': '인간과환경', 'credit': 3, 'professor': '안진선'},
  {'area': '2영역', 'lecture': '인간관계론', 'credit': 3, 'professor': '권재기'},
  {'area': '2영역', 'lecture': '인간관계론', 'credit': 3, 'professor': '박선환'},
  {'area': '2영역', 'lecture': '인간관계론', 'credit': 3, 'professor': '손원영'},
  {'area': '6영역', 'lecture': '인공지능과미래사회', 'credit': 3, 'professor': '양애경'},
  {'area': '2영역', 'lecture': '인권과복지사회', 'credit': 3, 'professor': '문영주'},
  {'area': '융합', 'lecture': '인문・심리 치유실습', 'credit': 3, 'professor': '전지니'},
  {'area': '융합', 'lecture': '인문・심리 치유실습', 'credit': 3, 'professor': '조영주'},
  {'area': '7영역', 'lecture': '일반물리실험2', 'credit': 1, 'professor': '최용수'},
  {'area': '7영역', 'lecture': '일반물리실험2', 'credit': 1, 'professor': '이현'},
  {'area': '7영역', 'lecture': '일반물리실험2', 'credit': 1, 'professor': '양우일'},
  {'area': '7영역', 'lecture': '일반물리학2', 'credit': 3, 'professor': '양우일'},
  {'area': '7영역', 'lecture': '일반물리학2', 'credit': 3, 'professor': '최용수'},
  {'area': '7영역', 'lecture': '일반물리학2', 'credit': 3, 'professor': '이현'},
  {'area': '7영역', 'lecture': '일반물리학2', 'credit': 3, 'professor': '오기영'},
  {'area': '7영역', 'lecture': '일반물리학및실험2', 'credit': 3, 'professor': '최홍'},
  {'area': '7영역', 'lecture': '일반물리학및실험2', 'credit': 3, 'professor': '박종순'},
  {'area': '7영역', 'lecture': '일반화학', 'credit': 3, 'professor': '김미수'},
  {'area': '7영역', 'lecture': '일반화학2', 'credit': 3, 'professor': '임민경'},
  {'area': '7영역', 'lecture': '일반화학및실험1', 'credit': 3, 'professor': '김미수'},
  {'area': '7영역', 'lecture': '일반화학및실험1', 'credit': 3, 'professor': '오영호'},
  {'area': '7영역', 'lecture': '일반화학및실험1', 'credit': 3, 'professor': '양도현'},
  {'area': '7영역', 'lecture': '일반화학및실험1', 'credit': 3, 'professor': '한기종'},
  {'area': '7영역', 'lecture': '일반화학및실험2', 'credit': 3, 'professor': '이승훈'},
  {'area': '7영역', 'lecture': '일반화학및실험2', 'credit': 3, 'professor': '오영호'},
  {'area': '7영역', 'lecture': '일반화학실험1', 'credit': 1, 'professor': '임민경'},
  {'area': '7영역', 'lecture': '일반화학실험1', 'credit': 1, 'professor': '한기종'},
  {'area': '7영역', 'lecture': '일반화학실험2', 'credit': 1, 'professor': '임민경'},
  {'area': '5영역', 'lecture': '일본어', 'credit': 3, 'professor': '오영숙'},
  {'area': '5영역', 'lecture': '일본어', 'credit': 3, 'professor': '이경화'},
  {'area': '2영역', 'lecture': '자기이해와생애설계', 'credit': 3, 'professor': '정유선'},
  {'area': '소양', 'lecture': '자기주도적학습법', 'credit': 3, 'professor': '박효정'},
  {'area': '7영역', 'lecture': '자연과학의이해', 'credit': 3, 'professor': '오기영'},
  {'area': '8영역', 'lecture': '재생에너지와인간삶', 'credit': 3, 'professor': '최용수'},
  {'area': '2영역', 'lecture': '재테크와실용금융', 'credit': 3, 'professor': '정진'},
  {'area': '2영역', 'lecture': '정신건강프로젝트', 'credit': 3, 'professor': '미정'},
  {'area': '6영역', 'lecture': '제4차산업혁명핵심기술의이해', 'credit': 3, 'professor': '김현주'},
  {'area': '5영역', 'lecture': '중국어', 'credit': 3, 'professor': '김영현'},
  {'area': '5영역', 'lecture': '중국어', 'credit': 3, 'professor': '주신전'},
  {'area': '소양', 'lecture': '지속가능한발전', 'credit': 1, 'professor': '최동욱'},
  {'area': '융합', 'lecture': '지식경영을위한컴퓨터활용', 'credit': 3, 'professor': '최선주'},
  {'area': '융합', 'lecture': '지식경영을위한컴퓨터활용', 'credit': 3, 'professor': '양성미'},
  {'area': '6영역', 'lecture': '지적재산권의이해', 'credit': 3, 'professor': '미정'},
  {'area': '소양', 'lecture': '진로선택과취업준비', 'credit': 2, 'professor': '대학일자리센터'},
  {'area': '소양', 'lecture': '창업제대로하기', 'credit': 3, 'professor': '대학일자리센터'},
  {'area': '5영역', 'lecture': '창의성계발', 'credit': 3, 'professor': '권재기'},
  {'area': '5영역', 'lecture': '창의성계발', 'credit': 3, 'professor': '권희철'},
  {'area': '2영역', 'lecture': '창의와소통', 'credit': 3, 'professor': '권희철'},
  {'area': '2영역', 'lecture': '청년의삶과사회환경', 'credit': 3, 'professor': '박정배'},
  {'area': '소양', 'lecture': '취업준비실무', 'credit': 2, 'professor': '대학일자리센터'},
  {'area': '4영역', 'lecture': '통일과한반도미래', 'credit': 3, 'professor': '배종렬'},
  {'area': '4영역', 'lecture': '통일과한반도미래', 'credit': 3, 'professor': '미정'},
  {'area': '3영역', 'lecture': '특수교육학개론', 'credit': 2, 'professor': '박미연'},
  {'area': '6영역', 'lecture': '프로그래밍언어의이해', 'credit': 3, 'professor': '양애경'},
  {'area': '8영역', 'lecture': '필라테스와에스테틱', 'credit': 2, 'professor': '남미희'},
  {'area': '8영역', 'lecture': '필라테스와에스테틱', 'credit': 2, 'professor': '안용길'},
  {'area': '공통과목', 'lecture': '한경디지로그:이슈와토론', 'credit': 2, 'professor': '김원철'},
  {'area': '공통과목', 'lecture': '한경디지로그:이슈와토론', 'credit': 2, 'professor': '권혜린'},
  {'area': '공통과목', 'lecture': '한경디지로그:이슈와토론', 'credit': 2, 'professor': '마상룡'},
  {'area': '공통과목', 'lecture': '한경디지로그:이슈와토론', 'credit': 2, 'professor': '미정'},
  {'area': '공통과목', 'lecture': '한경디지로그:이슈와토론', 'credit': 2, 'professor': '이정민'},
  {'area': '4영역', 'lecture': '한국근현대사', 'credit': 3, 'professor': '박윤진'},
  {'area': '1영역', 'lecture': '한국명문과상상력', 'credit': 3, 'professor': '박춘희'},
  {'area': '4영역', 'lecture': '한국문화와교육', 'credit': 3, 'professor': '이유정'},
  {'area': '4영역', 'lecture': '한국문화와교육', 'credit': 3, 'professor': '김혜진'},
  {'area': '4영역', 'lecture': '한국문화와교육', 'credit': 3, 'professor': '김영래'},
  {'area': '4영역', 'lecture': '한국역사와문화', 'credit': 3, 'professor': '윤휘탁'},
  {'area': '4영역', 'lecture': '한국역사와문화', 'credit': 3, 'professor': '미정'},
  {'area': '1영역', 'lecture': '한국인의삶과문학', 'credit': 3, 'professor': '황치복'},
  {'area': '소양', 'lecture': '합창', 'credit': 3, 'professor': '백은경'},
  {'area': '2영역', 'lecture': '행복의심리', 'credit': 3, 'professor': '조영주'},
  {'area': '3영역', 'lecture': '현대사회와교육 ', 'credit': 3, 'professor': '손원영'},
  {'area': '3영역', 'lecture': '현대사회와교육 ', 'credit': 3, 'professor': '최철용'},
  {'area': '3영역', 'lecture': '현대사회와교육 ', 'credit': 3, 'professor': '김혜진'},
  {'area': '8영역', 'lecture': '현대사회와스포츠', 'credit': 3, 'professor': '김규호'},
  {'area': '8영역', 'lecture': '현대사회와스포츠', 'credit': 3, 'professor': '김동규'},
  {'area': '1영역', 'lecture': '현대생활과디자인', 'credit': 3, 'professor': '오승희'},
  {'area': '3영역', 'lecture': '현대인과 윤리', 'credit': 3, 'professor': '김종진'},
  {'area': '4영역', 'lecture': '현대중국의이해', 'credit': 3, 'professor': '윤휘탁'},
  {'area': '4영역', 'lecture': '현대중국의이해', 'credit': 3, 'professor': '김지훈'},
  {'area': '7영역', 'lecture': '확률과통계', 'credit': 3, 'professor': '허다연'},
  {'area': '7영역', 'lecture': '확률과통계', 'credit': 3, 'professor': '강철'},
  {'area': '7영역', 'lecture': '확률과통계', 'credit': 3, 'professor': '박정주'},
  {'area': '8영역', 'lecture': '환경윤리', 'credit': 3, 'professor': '김원철'}
];
