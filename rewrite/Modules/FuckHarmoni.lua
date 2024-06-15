function quaverParse(file)   
    -- huge credits to https://github.com/AGORI-Studios/Rit for this part
        chart = tinyyaml.parse(love.filesystem.read(file))
        lanes = {}
        timingPointsTable = {}
        scrollVelocities = {}
        totalNoteCount = 0
        holdNoteCount = 0
        for i = 1,7 do
            table.insert(lanes, {})
        end
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
            local endTime = hitObject.EndTime or 0
            local lane = hitObject.Lane
            totalNoteCount = totalNoteCount + 1
            if endTime > 0 then
                holdNoteCount = holdNoteCount + 1
            end
            local note = Objects.Game.Note(startTime, lane, endTime)
            table.insert(lanes[lane], note)   
            if not firstNoteTime and startTime then
                firstNoteTime = math.floor(startTime/1000)
                print("first note time: ".. firstNoteTime)
            end       
            lastNoteTime = startTime -- this should work because the last time its run will be the last note      
            ::continue::
        end
        print("Total Note Count: ".. totalNoteCount)
        songLength = song:getDuration()
        print(songLength)
        songLengthToLastNote = lastNoteTime/1000
        bestScorePerNote = 1000000/(#lanes[1]+#lanes[2]+#lanes[3]+#lanes[4])
        holdNotePercent = math.ceil((holdNoteCount / totalNoteCount)*100)
        currentBpm = metaData.bpm
        if currentBpm then
        print("BPM: "..currentBpm)
        end
    return true
end