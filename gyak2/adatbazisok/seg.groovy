atlag ertekeles mufaj alapjan

db.movies.aggregate([
  { $unwind: "$genres" },
  {
    $group: {
      _id: "$genres",
      avgRating: { $avg: "$imdb.rating" }
    }
  },
  { $sort: { avgRating: -1 } }  // opcionális: rendezés csökkenő sorrendben
])

A MongoDB Compass segítségével kérdezze le az előző feladatban létrehozott receptek gyűjtemény azon dokumentumait, amelyre teljesül:
a. A lájkok száma több, mint 2! b. A lista legyen sorbarendezve a főzési idő szerint csökkenő sorrendben! (A rendezés funkció az Options gomb lenyomása után érhető el) c. A listában ne jelenjenek meg az ingredients és a rating mezők (Project szakasznál kell beállítani)!

db.receptek.find({
"likes_count": {$gte: 2}
}).sort({"cook_time": -1},
{"ingredients": 0,"_id": 0}) //minden megjelenik csak ez nem, ha 1 akkor csak az adott jelenik meg


Melyik filmben volt a legtöbb szereplő?
🔹 Csak a film címe és a szereplők száma jelenjen meg
🔹 Használj sorba rendezést és LIMIT utasítást

MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH m.title AS film, COUNT(p) AS szereplok_szama
ORDER BY szereplok_szama DESC
LIMIT 1
RETURN film, szereplok_szama

