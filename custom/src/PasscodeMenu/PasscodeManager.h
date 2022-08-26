#pragma once

#include "AccessType.h"
#include <QObject>
#include <list>
#include <string>

class PasscodeManager : public QObject {
    Q_OBJECT
  public:
    PasscodeManager();
    ~PasscodeManager();
//    AccessType accessTypes;

    Q_INVOKABLE QString submitPasscode(QString passcode);
    void setConfigFile(std::string fileName);
    std::list<QString> getPasscodes();
//    void changeAccess(AccessType accesstype);

  
  private:
    std::list<QString> _passcodes;
    void _initPasscodes();
    std::string _configFile;
};
