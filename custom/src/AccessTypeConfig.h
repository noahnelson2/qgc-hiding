#pragma once
#ifndef ACCESSTYPECONFIG_H
#define ACCESSTYPECONFIG_H
#include "AccessType.h"
#include "QGCCorePlugin.h"

AccessType getInitialUserAccessType();
void setInitialUserAccessType(QString access);
//AccessType CURRENT_USER_ACCESS_TYPE = Basic;

#endif // ACCESSTYPECONFIG_H
