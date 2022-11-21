class Time
    @@delta_time = 0
    @@last = 0

    def self.now
        Gosu::milliseconds
    end

    def self.delta_time
        @@delta_time
    end

    def self.since(time)
        Gosu::milliseconds - time
    end

    def self.update
        @@delta_time = Time.since(@@last)
        @@last = Time.now
    end
end