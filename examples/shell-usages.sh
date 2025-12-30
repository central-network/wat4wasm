cd 01-text
cp ../../wat4wasm wat4wasm
./wat4wasm --input=module.wat --output=module-output.wat
rm wat4wasm
cd ..

cd 02-include
cp ../../wat4wasm wat4wasm
./wat4wasm --input=module.wat --output=module-output.wat
rm wat4wasm
cd ..

cd 03-ref.extern
cp ../../wat4wasm wat4wasm
./wat4wasm --input=module.wat --output=module-output.wat
rm wat4wasm
cd ..

cd 04-ref.func
cp ../../wat4wasm wat4wasm
./wat4wasm --input=module.wat --output=module-output.wat
rm wat4wasm
cd ..

cd 05-global.get
cp ../../wat4wasm wat4wasm
./wat4wasm --input=module.wat --output=module-output.wat
rm wat4wasm
cd ..

cd 06-async
cp ../../wat4wasm wat4wasm
./wat4wasm --input=module.wat --output=module-output.wat
rm wat4wasm
cd ..

cd 07-data
cp ../../wat4wasm wat4wasm
./wat4wasm --input=module.wat --output=module-output.wat --wat2wasm=wat2wasm
rm wat4wasm
cd ..

cd 08-reflectors
cp ../../wat4wasm wat4wasm
./wat4wasm --input=module.wat --output=module-output.wat
rm wat4wasm
cd ..

cd 09-replaceAll
cp ../../wat4wasm wat4wasm
./wat4wasm --input=module.wat --output=module-output.wat
rm wat4wasm
cd ..


cd 99-complex
cp ../../wat4wasm wat4wasm
./wat4wasm --input=module.wat --output=output.html --wat2wasm=wat2wasm --keep-window --keep-chrome-global --keep-document --wasm-from-numbers-array --log-instance --debug-names --enable-threads
rm wat4wasm
cd ..
