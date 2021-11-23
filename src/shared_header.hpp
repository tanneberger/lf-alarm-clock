
#ifndef SHARED_HEADER_INCLUDE_GUARD
#define SHARED_HEADER_INCLUDE_GUARD

#include <iostream>
#include <string>
#include <thread>
#include <fstream>
#include <filesystem>
#include <boost/asio.hpp>

struct Event {
    std::string message_;
    unsigned int time_stamp_;
};

// very simple struct to handle http request
struct ParsedHeader {
    std::string method_;
    std::string endpoint_;
    std::string body_;
};

constexpr const char* kMusicDir = "/home/revol-xut/music/AlarmClock/";
constexpr const char* kFile = "./alarm_clock_events.csv";

constexpr short kBackLog = 30;
constexpr unsigned short kPort = 6666;

#endif //SHARED_HEADER_INCLUDE_GUARD

