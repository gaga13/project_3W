1.weatherTest : 지역 이름으로 입력 받아서 좌표로 변환 후 해당 지역의 실시간 날씨 출력
controller의 관련 value : weather, split

2.weatherTest2 : 현재 위치 자동으로 받아와서 해당 지역의 실시간 날씨 출력. sessionSave 먼저 실행 필요
controller의 관련 value : weather2

3.weatherTest3 : 현재 위치 자동으로 받아와서 향후 5일간 날씨 3시간 간격으로 출력. sessionSave 먼저 실행 필요
controller의 관련 value : weather3

4.sessionSave : 현재 위치 자동으로 받아오기 위해 사용. 로그인 성공시 실행되도록 하면 됨.
controller의 관련 value : sessionSave, locationSave

+ 번역 필요할 시 controller의 translate 활용.