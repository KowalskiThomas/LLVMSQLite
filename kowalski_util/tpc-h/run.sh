mv ../../release/sqlite3.ll ../../
rm -f ../../release/*.ll  
mv ../../sqlite3.ll ../../release
python3  multirunner.py  $db -count $1

