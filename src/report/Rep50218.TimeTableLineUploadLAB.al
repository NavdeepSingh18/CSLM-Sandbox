// report 50218 "Time Table (LAB)"
// {
//     UsageCategory = None;
//     //ApplicationArea = All;
//     ProcessingOnly = true;

//     dataset
//     {


//     }
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     Field(FileName; FileName)
//                     {
//                         ApplicationArea = All;
//                         trigger OnValidate()
//                         begin
//                             RequestFile();
//                         end;

//                         trigger OnAssistEdit()
//                         begin
//                             RequestFile();
//                             SheetName := Excelbuffer.SelectSheetsName(ServerfileName);
//                         end;
//                     }
//                     Field(SheetName; SheetName)
//                     {
//                         ApplicationArea = All;
//                         Enabled = false;
//                         Trigger OnAssistEdit()
//                         begin
//                             IF ServerFileName = '' THEN
//                                 RequestFile;

//                             SheetName := ExcelBuffer.SelectSheetsName(ServerFileName);
//                         end;
//                     }
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }
//     }

//     Trigger OnPreReport()
//     begin
//         ExcelBuffer.LOCKTABLE();
//         ExcelBuffer.OpenBook(ServerFileName, SheetName);
//         ExcelBuffer.ReadSheet();
//         GetLastRowandColumn();

//         FOR X := 2 TO TotalRows DO
//             InsertData(X);

//         ExcelBuffer.DELETEALL();
//         MESSAGE('Import Completed');

//     end;

//     var
//         Excelbuffer: Record "Excel Buffer";
//         Filemgt: Codeunit "File Management";
//         SheetName: Text;
//         FileName: Text;
//         ServerfileName: Text;
//         Window: Dialog;
//         TotalColumns: Integer;
//         TotalRows: Integer;
//         X: Integer;

//     procedure RequestFile()
//     begin
//         IF FileName <> '' THEN
//             ServerFileName := FileMgt.UploadFile('Import Excel File', FileName)
//         ELSE
//             ServerFileName := FileMgt.UploadFile('Import Excel File', '.xlsx');

//         ValidateServerFileName;
//         FileName := FileMgt.GetFileName(ServerFileName);

//     end;

//     procedure ValidateSErverFileName()
//     Begin
//         IF ServerFileName = '' THEN BEGIN
//             FileName := '';
//             SheetName := '';
//             ERROR('You must enter a file name.');
//         END;
//     End;

//     procedure GetLastRowandColumn()
//     begin
//         ExcelBuffer.SETRANGE("Row No.", 1);
//         TotalColumns := ExcelBuffer.COUNT;

//         ExcelBuffer.RESET;
//         IF ExcelBuffer.FINDLAST THEN
//             TotalRows := ExcelBuffer."Row No.";
//     end;

//     procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
//     Var
//         ExcelBuf1: Record "Excel Buffer";
//     Begin
//         IF ExcelBuf1.GET(RowNo, ColNo) THEN
//             EXIT(ExcelBuf1."Cell Value as Text");
//         EXIT('');
//     end;

//     Procedure InsertData(RowNo: Integer)
//     var
//         ClassTimeTableLine: Record "Class Time Table Line-CS";
//         Employee_lRec: Record Employee;
//         Date_lRec: Record Date;
//     begin
//         ClassTimeTableLine.Reset();
//         ClassTimeTableLine.SetRange("Document No.", GetValueAtCell(RowNo, 1));
//         ClassTimeTableLine.SetFilter("Line No.", GetValueAtCell(RowNo, 2));
//         If ClassTimeTableLine.Findfirst() then begin
//             ClassTimeTableLine."Time Slot" := GetValueAtCell(RowNo, 3);
//             Evaluate(ClassTimeTableLine.Day, GetValueAtCell(RowNo, 4));
//             ClassTimeTableLine.Section := GetValueAtCell(Rowno, 5);
//             ClassTimeTableLine."Subject Category" := GetValueAtCell(Rowno, 6);
//             ClassTimeTableLine."Subject Group" := GetValueAtCell(RowNo, 7);
//             ClassTimeTableLine."Subject Class" := GetValueAtCell(RowNo, 8);
//             ClassTimeTableLine.Validate("Subject Code", GetValueAtCell(RowNo, 9));
//             //ClassTimeTableLine.Validate("Topic Code", GetValueAtCell(RowNo, 11));
//             ClassTimeTableLine.Batch := GetValueAtCell(RowNo, 11);
//             ClassTimeTableLine.Validate("Room No", GetValueAtCell(RowNo, 12));

//             ClassTimeTableLine."Faculty 1 Code" := GetValueAtCell(RowNo, 13);
//             Employee_lRec.Reset();
//             Employee_lRec.SetRange("No.", GetValueAtCell(RowNo, 13));
//             IF Employee_lRec.FindFirst() then
//                 ClassTimeTableLine."Faculty 1 Name" := Employee_lRec."First Name" + ' ' + Employee_lRec."Last Name";

//             ClassTimeTableLine."Faculty 2 Code" := GetValueAtCell(RowNo, 14);
//             Employee_lRec.Reset();
//             Employee_lRec.SetRange("No.", GetValueAtCell(RowNo, 14));
//             IF Employee_lRec.FindFirst() then
//                 ClassTimeTableLine."Faculty 2 Name" := Employee_lRec."First Name" + ' ' + Employee_lRec."Last Name";

//             ClassTimeTableLine."Faculty 3 Code" := GetValueAtCell(RowNo, 15);
//             Employee_lRec.Reset();
//             Employee_lRec.SetRange("No.", GetValueAtCell(RowNo, 15));
//             IF Employee_lRec.FindFirst() then
//                 ClassTimeTableLine."Faculty 3 Name" := Employee_lRec."First Name" + ' ' + Employee_lRec."Last Name";

//             ClassTimeTableLine."Faculty 4 Code" := GetValueAtCell(RowNo, 16);
//             Employee_lRec.Reset();
//             Employee_lRec.SetRange("No.", GetValueAtCell(RowNo, 16));
//             IF Employee_lRec.FindFirst() then
//                 ClassTimeTableLine."Faculty 4 Name" := Employee_lRec."First Name" + ' ' + Employee_lRec."Last Name";

//             EValuate(ClassTimeTableLine."Start Date", GetValueAtCell(RowNo, 17));

//             Date_lRec.Reset();
//             Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
//             Date_lRec.SetRange("Period Start", ClassTimeTableLine."Start Date");
//             Date_lRec.SetRange("Period Name", Format(ClassTimeTableLine.Day));
//             Date_lRec.FindFirst();

//             ClassTimeTableLine.Modify();
//         end;

//     end;
// }