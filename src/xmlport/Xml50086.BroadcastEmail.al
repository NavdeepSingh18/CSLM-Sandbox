xmlport 50086 BroadcastEmail
{
    Direction = Import;
    FieldSeparator = ',';
    Format = VariableText;
    UseRequestPage = false;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'StudentBroadcast';
                textelement(EnrollmentNo)
                {

                }

                trigger OnBeforeInsertRecord()
                var
                    StudentMaster_lRec: Record "Student Master-CS";

                    EntryNo: Integer;
                Begin
                    EntryNo := 0;
                    If SkipFirstLine then begin
                        SkipFirstLine := False;
                    end ELSE begin
                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetRange("No.", EnrollmentNo);
                        If StudentMaster_lRec.FindFirst() then begin

                            TempTable_lRec.Reset();
                            If TempTable_lRec.FindLast() then
                                EntryNo := TempTable_lRec."Entry No" + 1
                            Else
                                EntryNo := 1;

                            TempTable_lRec.Init();
                            TempTable_lRec."Entry No" := EntryNo;
                            TempTable_lRec.Field12 := StudentMaster_lRec."Original Student No.";
                            TempTable_lRec.Field2 := StudentMaster_lRec."No.";
                            TempTable_lRec.Field11 := StudentMaster_lRec."Student Name";
                            TempTable_lRec.Field3 := StudentMaster_lRec."Course Code";
                            TempTable_lRec.Field4 := StudentMaster_lRec."Academic Year";
                            TempTable_lRec.Field5 := StudentMaster_lRec.Semester;
                            TempTable_lRec.Field7 := StudentMaster_lRec.Status;
                            TempTable_lRec.Field13 := StudentMaster_lRec."E-Mail Address";
                            TempTable_lRec."Unique ID" := UserId();
                            TempTable_lRec.Insert();
                        end;
                    end;
                    currXMLport.Skip();
                End;
            }
        }
    }
    Var
        TempTable_lRec: Record "Temp Record";
        SkipFirstLine: Boolean;

    trigger OnPreXmlPort()
    Begin
        TempTable_lRec.Reset();
        TempTable_lRec.DeleteAll();
    End;


}