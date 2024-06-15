function quaverParse(file)   
    print("quaverParse()")
    -- huge credits to https://github.com/AGORI-Studios/Rit for this part
        chart = tinyyaml.parse(love.filesystem.read(file))
        homerLanes = {}
        homieLanes = {}
        timingPointsTable = {}
        scrollVelocities = {}
        totalNoteCount = 0
        holdNoteCount = 0
        for i = 1,4 do
            table.insert(homerLanes, {})
            table.insert(homieLanes, {})
        end

        lane1 = {}
        banner = nil
        metaData = {
            name = chart.Title,
            song = chart.AudioFile,
            artist = chart.Artist,
            source = chart.Source, -- not sure what this one even is really
            tags = chart.Tags, -- not gonna be used in this file but im putting it here for now so i dont forget it
            diffName = chart.DifficultyName,
            creator = chart.Creator,
            background = chart.BackgroundFile,
            banner = chart.BannerFile or nil,
            previewTime = (chart.SongPreviewTime or 0), -- also wont be used here
            noteCount = 0,
            length = 0,
            bpm = 0,
        }
        firstNoteTime = nil
        for i = 1,#chart.HitObjects do
            local hitObject = chart.HitObjects[i]
            local startTime = (hitObject.StartTime or 0)
            if not startTime then goto continue end
            local lane = hitObject.Lane
            note = {}
            local time = startTime
            note.time = startTime
            totalNoteCount = totalNoteCount + 1

            table.insert(homerLanes[lane], startTime)
            table.insert(homieLanes[lane], startTime)   
            if lane == 1 then
            table.insert(lane1, time)
            end
   
            if not firstNoteTime and startTime then
                firstNoteTime = math.floor(startTime/1000)
                print("first note time: ".. firstNoteTime)
            end       
            lastNoteTime = startTime -- this should work because the last time its run will be the last note      
            ::continue::
        end
        print("Total Note Count: ".. totalNoteCount)
        songLengthToLastNote = lastNoteTime/1000
        bestScorePerNote = 1000000/(#homerLanes[1]+#homerLanes[2]+#homerLanes[3]+#homerLanes[4])
        holdNotePercent = math.ceil((holdNoteCount / totalNoteCount)*100)
        currentBpm = metaData.bpm
        if currentBpm then
        print("BPM: "..currentBpm)
        end
    return true
end