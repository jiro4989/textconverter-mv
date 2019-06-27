import unittest

include txtconv4mv/project

suite "proc readMapInfos":
  test "Normal":
    echo readMapInfos("examples/MapInfos.json")

suite "proc getBiggestMapIndex":
  test "Normal":
    echo getBiggestMapIndex("examples")

suite "proc newMapObject":
  test "Normal":
    echo newMapObject(Sentences(@[Sentence(actorName: "test", text: "123456")]), ["<<", ">>"], 4, true, ["「"," 」"]).pretty

suite "proc addMapInfo":
  proc mi(id: int): MapInfo = MapInfo(id: id, order: id, name: "txtconv4mv")
  setup:
    var infos: MapInfos
    var n: MapInfo
    infos.add(n)
    infos.add(mi(1))
    infos.add(mi(2))
  test "Add last":
    infos.addMapInfo
    let item = MapInfos(@[nil, mi(1), mi(2), mi(3)])
    check infos[0] == item[0]
    check infos[1][] == item[1][]
    check infos[2][] == item[2][]
    check infos[3][] == item[3][]
  test "Add 1":
    infos[1] = nil
    infos[2].order = 1
    infos.addMapInfo
    let item = MapInfos(@[nil, MapInfo(id: 1, order: 2, name: "txtconv4mv"),
                               MapInfo(id: 2, order: 1, name: "txtconv4mv")])
    check infos[0] == item[0]
    check infos[1][] == item[1][]
    check infos[2][] == item[2][]