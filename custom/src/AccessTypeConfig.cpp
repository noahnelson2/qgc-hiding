#include "AccessTypeConfig.h"
#include "QGCCorePlugin.h"


//AccessType CURRENT_USER_ACCESS_TYPE = Basic;
//AccessType CURRENT_USER_ACCESS_TYPE = Expert;
AccessType CURRENT_USER_ACCESS_TYPE = Factory;

AccessType getInitialUserAccessType() {
    return CURRENT_USER_ACCESS_TYPE;
}

void setInitialUserAccessType(QString access){
    std::string newAccessType = access.toStdString();
    if (newAccessType == accessTypeString(AccessType::Basic)) {
       CURRENT_USER_ACCESS_TYPE= AccessType::Basic;
    } else if (newAccessType == accessTypeString(AccessType::Expert)) {
       CURRENT_USER_ACCESS_TYPE = AccessType::Expert;
    } else if (newAccessType == accessTypeString(AccessType::Factory)) {
        CURRENT_USER_ACCESS_TYPE = AccessType::Factory;
    } else
        CURRENT_USER_ACCESS_TYPE = AccessType::Basic;
}
