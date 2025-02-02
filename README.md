# flutter_tictactoe_game

Flutter เกม XO

## การติดตั้ง


```sh
git clone https://github.com/PhaiWisit/Flutter-TicTacToe-Game.git

cd flutter_tictactoe_game

flutter pub get

flutter run
```

## ข้อมูล

- Flutter 3.24.5

- Dart 3.5.4

- Hive (Database)

- GetX (State Management)

### การจัดการข้อมูล
- ใช้ GetX ในการจัดการ state ของแอปพลิเคชัน โดยแบ่งออกเป็น 3 modules คือ Home, Play และ History แต่ละ module จะมี controller สำหรับจัดการข้อมูลเพื่อไปแสดงผลในหน้า UI
- Hive สำหรับเก็บข้อมูลประวัติการเล่น ซึ่งเป็นการเก็บข้อมูลในรูปแบบ key-value ซึ่งสามารถเก็บ value เป็น object ในหน่วยความจำเครื่องได้

ตัวอย่างโครงสร้างข้อมูลที่เก็บ
```sh
{
  "id": 0,
  "gameSize": 3,
  "gameTable": ["X", "O", "", "X", "O", "", "", "X", "O"],
  "winner": "X",
  "winIndex": [0, 3, 6],
  "tapIndex": [0, 1, 3, 4, 6],
  "gameMode": "twoPlayer",
  "timestamp": "2025-01-31T04:48:26.324Z"
}

	•	gameSize → ขนาดกระดาน
	•	gameTable → สถานะของช่องบนกระดาน
	•	winner → ผู้ชนะ (X, O หรือ Draw)
	•	winIndex → ช่องที่ชนะ
	•	tapIndex → ช่องที่ถูกกด
	•	gameMode → onePlayer หรือ twoPlayer
	•	timestamp → เวลาที่เกมจบ
```

### การทำงานของ Bot
- ใช้หลักการของ Newell and Simon's 1972 tic-tac-toe program สำหรับการทำงานของ Bot https://stackoverflow.com/a/125596

## Screenshots

| Home                                                                                                                                      | Play1                                                                                                                                        | Play2                                                                                                                                      | Play3                                                                                                                                      | History List                                                                                                                                          | History Detail                                                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/PhaiWisit/Flutter-TicTacToe-Game/blob/main/screenshot/s1.png?raw=true" width="350"> | <img src="https://github.com/PhaiWisit/Flutter-TicTacToe-Game/blob/main/screenshot/s2.png?raw=true" width="350"> | <img src="https://github.com/PhaiWisit/Flutter-TicTacToe-Game/blob/main/screenshot/s3.png?raw=true" width="350"> | <img src="https://github.com/PhaiWisit/Flutter-TicTacToe-Game/blob/main/screenshot/s4.png?raw=true" width="350"> | <img src="https://github.com/PhaiWisit/Flutter-TicTacToe-Game/blob/main/screenshot/s5.png?raw=true" width="350"> | <img src="https://github.com/PhaiWisit/Flutter-TicTacToe-Game/blob/main/screenshot/s6.png?raw=true" width="350"> |
