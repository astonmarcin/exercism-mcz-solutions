class Scale:
    scale = {
        "sharp": [ "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#" ],
        "flat": [ "A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab" ],
    }
    sharps = [ "C", "G", "D", "A", "E", "B", "F#", "a", "e", "b", "f#", "c#", "g#", "d#" ]
    flats = [ "F", "Bb", "Eb", "Ab", "Db", "Gb", "d", "g", "c", "f", "bb", "eb" ]

    def __init__(self, tonic):
        if tonic[0].islower():
            self.tonic = tonic[0].upper() + tonic[1:]
        else:
            self.tonic = tonic
        if tonic in self.sharps:
            self._scale = "sharp"
        else:
            self._scale = "flat"

    def chromatic(self):
        idx = self.scale[self._scale].index(self.tonic)
        return self.scale[self._scale][idx:] + self.scale[self._scale][:idx]

    def interval(self, intervals: list):
        interval_jump = {
            "m": 1,
            "M": 2,
            "A": 3,
        }
        tonic_idx = self.scale[self._scale].index(self.tonic)
        length = len(self.scale[self._scale])
        
        def idx_generator(idx):
            for interval in intervals:
                yield idx
                idx = (idx + interval_jump[interval]) % length
            yield idx

        return [self.scale[self._scale][idx] for idx in idx_generator(tonic_idx)]

