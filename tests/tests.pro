TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
QT += qml

TARGET = protobuf_qt_test
DEFINES += PROTOBUF_USE_DLLS

INCLUDEPATH += $$(PROTOBUF_SRC)
LIBS += -L$$(PROTOBUF_LIBS)
win32:LIBS += -llibprotobuf

unix:LIBS += -lprotobuf

SOURCES += main_test.cpp

PROTOS = test_messages_proto3.proto

win32:PROTOC = $$(PROTOBUF_SRC)/../bin/win32-msvc/protoc.exe
win32:PROTOC_GEN_QT=$$(PROTOBUF_SRC)/../bin/win32-msvc/protoc-gen-qt.exe
unix:PROTOC = $$(PROTOBUF_SRC)/../bin/$$[QMAKE_XSPEC]/protoc
unix:PROTOC_GEN_QT=$$(PROTOBUF_SRC)/../bin/$$[QMAKE_XSPEC]/protoc-gen-qt

protobuf_decl.name = protobuf headers
protobuf_decl.input = PROTOS
protobuf_decl.output = ${QMAKE_FILE_IN_PATH}/${QMAKE_FILE_BASE}.pb.h
protobuf_decl.commands = $${PROTOC} --plugin=protoc-gen-qt=$${PROTOC_GEN_QT} --cpp_out=${QMAKE_FILE_IN_PATH} --qt_out=${QMAKE_FILE_IN_PATH} -I=${QMAKE_FILE_IN_PATH} -I=$${INCLUDEPATH} ${QMAKE_FILE_IN}
protobuf_decl.variable_out = HEADERS
QMAKE_EXTRA_COMPILERS += protobuf_decl

protobuf_impl.name = protobuf sources
protobuf_impl.input = PROTOS
protobuf_impl.output = ${QMAKE_FILE_IN_PATH}/${QMAKE_FILE_BASE}.pb.cc
protobuf_impl.depends = ${QMAKE_FILE_IN_PATH}/${QMAKE_FILE_BASE}.pb.h
protobuf_impl.commands = $$escape_expand(\n)
protobuf_impl.variable_out = SOURCES
QMAKE_EXTRA_COMPILERS += protobuf_impl

