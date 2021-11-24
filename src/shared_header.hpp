
#ifndef SHARED_HEADER_INCLUDE_GUARD
#define SHARED_HEADER_INCLUDE_GUARD

#include <iostream>
#include <string>
#include <thread>
#include <fstream>
#include <filesystem>

struct Event {
    std::string message_;
    unsigned int time_stamp_;
};

constexpr const char* kMusicDir = "/home/revol-xut/music/AlarmClock/";
constexpr const char* kFile = "./alarm_clock_events.csv";

constexpr unsigned short kPort = 8680;

#endif //SHARED_HEADER_INCLUDE_GUARD

