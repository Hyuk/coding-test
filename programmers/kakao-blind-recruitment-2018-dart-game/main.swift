func solution(_ dartResult: String) -> Int {
    // 각 기회의 점수를 저장할 배열 초기화
    var points: [Int] = []
    // 입력 문자열을 문자 배열로 변환하여 인덱스로 접근할 수 있도록 함
    let chars: [Character] = Array(dartResult)
    // 문자열에서 현재 처리할 위치를 나타내는 인덱스 변수
    var i: Int = 0

    // 다트 게임은 총 3번의 기회(라운드)로 구성되므로 3번 반복
    for _ in 0..<3 {
        var num: Int = 0
        
        // 1. 점수 파싱:
        // 만약 현재 문자가 "1"이고 그 다음 문자가 "0"이라면, 점수는 10임
        if chars[i] == "1" && i + 1 < chars.count && chars[i + 1] == "0" {
            num = 10
            i += 2  // 두 자릿수(1과 0)를 소비
        } else {
            // 그렇지 않으면 한 자리 숫자를 정수로 변환하여 사용
            num = Int(String(chars[i]))!
            i += 1  // 한 자릿수 소비
        }
        
        // 2. 보너스 처리:
        // 다음 문자는 보너스 영역 문자(S, D, T)임
        let bonus: Character = chars[i]
        var point: Int = 0
        // 보너스 문자에 따라 점수를 계산
        // S: 단순, D: 제곱, T: 세제곱
        switch bonus {
        case "S":
            point = num             // Single: 그대로 사용
        case "D":
            point = num * num         // Double: 제곱
        case "T":
            point = num * num * num   // Triple: 세제곱
        default:
            break
        }
        i += 1  // 보너스 문자 소비
        
        // 3. 옵션 처리:
        // 옵션은 '*' 또는 '#'가 있을 수 있으며, 없을 수도 있음
        if i < chars.count && (chars[i] == "*" || chars[i] == "#") {
            let option: Character = chars[i]
            if option == "*" {
                // 스타상: 현재 점수를 2배로 만듦
                point *= 2
                // 만약 이전 기회가 존재하면, 이전 기회의 점수도 2배로 만듦
                if !points.isEmpty {
                    points[points.count - 1] *= 2
                }
            } else if option == "#" {
                // 아차상: 현재 점수를 음수로 변경
                point *= -1
            }
            i += 1  // 옵션 문자 소비
        }
        
        // 현재 라운드에서 계산된 점수를 points 배열에 추가
        points.append(point)
    }
    
    // 4. 총 점수 계산:
    // 각 기회의 점수를 모두 합산
    var total: Int = 0
    for point: Int in points {
        total += point
    }
    
    // 계산된 총 점수를 반환
    return total
}

// 테스트 케이스 배열: 각 튜플은 (입력 문자열, 예상 점수)
let testCases: [(String, Int)] = [
    ("1S2D*3T", 37),
    ("1D2S#10S", 9),
    ("1D2S0T", 3),
    ("1S*2T*3S", 23),
    ("1D#2S*3S", 5),
    ("1T2D3D#", -4),
    ("1D2S3T*", 59)
]

// 각 테스트 케이스에 대해 solution 함수를 실행하고 결과를 출력
for (input, expected): (String, Int) in testCases {
    let result: Int = solution(input)
    print("Input: \(input) → 결과: \(result) (예상: \(expected))")
}