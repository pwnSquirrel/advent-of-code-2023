fn main() {
    let input = std::fs::read_to_string("../input.txt").unwrap();

    let res = part2(&input);
    println!("Part 2: {res}");
}

const PATTERNS: [&str; 18] = [
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "one", "two", "three", "four", "five", "six",
    "seven", "eight", "nine",
];

pub fn part2(input: &str) -> u64 {
    let mut sum: u64 = 0;

    for line in input.lines() {
        let first = find(line);
        let last = rfind(line);
        sum += first * 10 + last;
    }

    sum
}

fn find(s: &str) -> u64 {
    let mut pos = [usize::MAX; 18];

    for (i, n) in PATTERNS.iter().enumerate() {
        if let Some(p) = s.find(n) {
            pos[i] = p;
        }
    }

    let min_pos = pos.iter().enumerate().min_by_key(|e| e.1).unwrap().0;
    (min_pos % 9 + 1) as u64
}

fn rfind(s: &str) -> u64 {
    let mut pos: [i64; 18] = [-1; 18];

    for (i, n) in PATTERNS.iter().enumerate() {
        if let Some(p) = s.rfind(n) {
            pos[i] = p as i64;
        }
    }

    let min_pos = pos.iter().enumerate().max_by_key(|e| e.1).unwrap().0;
    (min_pos % 9 + 1) as u64
}
