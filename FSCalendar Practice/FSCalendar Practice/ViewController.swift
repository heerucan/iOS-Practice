//
//  ViewController.swift
//  FSCalendar Practice
//
//  Created by Thisisme Hi on 2021/06/23.
//

import UIKit

import FSCalendar
import SnapKit


class ViewController: UIViewController {
    
    
    // MARK: - Property
    
    let now = Date()
    
    var events = [Date]()
    
    let toggleButton : UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(pressToggleButton), for: .touchUpInside)
        return toggle
    }()
    
    
    
    // 날짜를 원하는 형식으로 바꿔줄 때 - DateFormatter
    let dateFormatter : DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") // 어느 나라의 날짜 형식을 보여줄 건지
        formatter.dateStyle = .full //
        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyy-MM-dd-EEEE"
        
        return formatter
    }()
    
    
    var calendar : FSCalendar = {
        let calendar = FSCalendar()
        
        // 스크롤 방향
        calendar.scrollDirection = .horizontal
        
        // 날짜 다중 선택
        calendar.allowsMultipleSelection = true
        
        // 캘린더의 보여지는 영역
        // calendar.scope = .week // week인 경우
        calendar.scope = .month // month인 경우
        
        // 색상 관련
        calendar.appearance.todayColor = .systemBlue // 오늘 날짜
        calendar.appearance.selectionColor = .systemOrange // 선택한 날짜
        calendar.appearance.weekdayTextColor = .black // 요일 색깔
        
        calendar.appearance.eventDefaultColor = .red // 이벤트 날짜 기본 색깔 - 하단의 동그라미
        calendar.appearance.eventSelectionColor = .green // 이벤트 날짜 선택 시 색깔 - 하단의 동그라미
        
        
        // 날짜 선택 시의 테두리
        calendar.appearance.borderRadius = 0.5 // 0이면 사각형
        
        
        // 헤더 관련
        calendar.appearance.headerTitleColor = .black // 년월 색
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 20, weight: .semibold) // 년월 폰트
        calendar.appearance.headerDateFormat = "YYYY년 MM월" // 헤더 날짜 형식
        calendar.headerHeight = 80 // 헤더 높이
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0 // 헤더의 양 사이드 이전, 이후 달 안보이게 하기
        
        
        // 요일 언어 설정 - 변경 방법(1)
        calendar.locale = Locale(identifier: "ko_KR")
        
        // 요일 언어 설정 - 변경 방법(2)
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "월"
        
        // 요일이 영어일 경우 - 대문자로 변경하고 싶을 경우
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase
        
        // 첫 번째 요일을 월요일로 설정하고 싶은 경우
        calendar.firstWeekday = 1 // 1부터 일 / 2-월 / 3-화 / 4-수 / 5-목 / 6-금
        
        
        calendar.placeholderType = .fillHeadTail
        
        return calendar
    }()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpEvents()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        print(dateFormatter.string(from: now))
        
        
        // DateComponents 사용하는 방법
        let churchDay = DateComponents(year: 2021, month: 06, day: 27)
        let churchDate = Calendar.current.date(from: churchDay)
        
        print(churchDate!, "교회가는 날")
        
        
    }
    
    
    // MARK: - UI
    
    func configureUI() {
        
        view.addSubview(toggleButton)
        view.addSubview(calendar)
        
        toggleButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        calendar.snp.makeConstraints { (make) in
            make.top.equalTo(toggleButton.snp.bottom).offset(10) // top 부분의 safeArea 고려해서 레이아웃 설정
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide) // 모든 edge 영역을 safeArea 고려해서 레이아웃 설정
            
        }
    }
    
    // MARK: - setUpEvent
    
    func setUpEvents() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        let teamBuilding = formatter.date(from: "2021년 06월 03일")
        let minjooBirth = formatter.date(from: "2021년 06월 27일")
        
        events = [teamBuilding!, minjooBirth!]
        
    }
    
    // 토글버튼 누르면 calendar.scope이 변경 -> 주에서 월로 변경
    @objc func pressToggleButton() {
        if (self.calendar.scope == .month) {
            self.calendar.scope = .week

        } else {
            self.calendar.scope = .month
            
        }
    }
    
}


// MARK: - FSCalendarDataSource

extension ViewController: FSCalendarDataSource {
    
    // 날짜 아래에 부제목을 다는 함수
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        
        var subTitle = String()
        
        if date == Calendar.current.date(from: DateComponents(year: 2021, month: 06, day: 27)) {
            subTitle = "교회"
            
        } else if date == Calendar.current.date(from: DateComponents(year: 2021, month: 06, day: 23)) {
            subTitle = "엄마생신"
        }
        
        return subTitle
        
    }
    
    
}

// MARK: - FSCalendarDelegate

extension ViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.events.contains(date) {
            return 1 // Int 값에 따라 하단의 이벤트 동그라미의 개수가 변한다.
            
        } else {
            return 0
        }
    }
    
    //    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
    //        calendar.frame = CGRect(
    //    }
}
