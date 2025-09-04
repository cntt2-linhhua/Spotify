# shopify

A new Flutter project.

Ver 1.2  sẽ build by data:
{
  "artists": [
    {
      "id": "a1",
      "name": "Sơn Tùng M-TP",
      "imageUrl": "https://example.com/artists/son-tung.jpg",
      "bio": "Ca sĩ, nhạc sĩ nhạc pop hàng đầu Việt Nam."
    },
    {
      "id": "a2",
      "name": "Ariana Grande",
      "imageUrl": "https://example.com/artists/ariana.jpg",
      "bio": "Nữ ca sĩ nhạc pop nổi tiếng thế giới."
    }
  ],
  "albums": [
    {
      "id": "al1",
      "title": "Sky Tour",
      "artistId": "a1",
      "coverUrl": "https://example.com/albums/skytour.jpg",
      "releaseDate": "2020-07-01"
    },
    {
      "id": "al2",
      "title": "Positions",
      "artistId": "a2",
      "coverUrl": "https://example.com/albums/positions.jpg",
      "releaseDate": "2020-10-30"
    }
  ],
  "songs": [
    {
      "id": "s1",
      "title": "Hãy Trao Cho Anh",
      "artistId": "a1",
      "albumId": "al1",
      "duration": 245,
      "audioUrl": "https://example.com/audio/haytraochoanh.mp3",
      "playCount": 1234567,
      "isFavorite": true,
      "lyricList": [
        { "time": 0, "text": "[Intro]" },
        { "time": 12, "text": "Hãy trao cho anh, hãy trao cho anh..." },
        { "time": 25, "text": "Ánh sáng nơi đây em có thấy không..." },
        { "time": 38, "text": "Anh mơ về em từng phút giây..." },
        { "time": 55, "text": "Trao nhau nụ hôn ngọt ngào này..." },
        { "time": 75, "text": "Bước đi cùng anh qua tháng năm..." },
        { "time": 95, "text": "Đừng rời xa anh nhé người ơi..." },
        { "time": 115, "text": "Hãy trao yêu thương đắm say..." },
        { "time": 135, "text": "Khi con tim ta hòa chung nhịp..." },
        { "time": 155, "text": "Và tình yêu sẽ mãi xanh..." },
        { "time": 180, "text": "[Rap: Snoop Dogg]" },
        { "time": 200, "text": "Yeah, it's Snoop D-O-double-G with M-TP..." },
        { "time": 220, "text": "We vibe all night, just you and me..." },
        { "time": 245, "text": "[Outro]" }
      ]
    },
    {
      "id": "s2",
      "title": "Positions",
      "artistId": "a2",
      "albumId": "al2",
      "duration": 173,
      "audioUrl": "https://example.com/audio/positions.mp3",
      "playCount": 2500345,
      "isFavorite": false,
      "lyricList": [
        { "time": 0, "text": "[Intro]" },
        { "time": 10, "text": "Heaven sent you to me..." },
        { "time": 22, "text": "I'm just hoping I don't repeat history..." },
        { "time": 35, "text": "Boy, I'm tryna meet your mama..." },
        { "time": 55, "text": "On a Sunday..." },
        { "time": 75, "text": "Then make a lotta love on a Monday..." },
        { "time": 95, "text": "Never need no, no one else, babe..." },
        { "time": 120, "text": "Switching the positions for you..." },
        { "time": 150, "text": "[Outro]" }
      ]
    }
  ],
  "playlists": [
    {
      "id": "p1",
      "title": "Top Hits Vietnam",
      "description": "Những bài hát hot nhất tại Việt Nam",
      "coverUrl": "https://example.com/playlists/tophitsvn.jpg",
      "songIds": ["s1"]
    },
    {
      "id": "p2",
      "title": "Pop Worldwide",
      "description": "Best of global pop",
      "coverUrl": "https://example.com/playlists/popworld.jpg",
      "songIds": ["s1", "s2"]
    }
  ],
  "users": [
    {
      "id": "u1",
      "name": "Linh",
      "email": "linh@example.com",
      "avatarUrl": "https://example.com/users/linh.jpg",
      "favoriteSongIds": ["s1"],
      "playlistIds": ["p1"]
    }
  ]
}
