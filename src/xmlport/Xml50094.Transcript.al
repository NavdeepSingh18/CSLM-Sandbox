XmlPort 50094 transcript////GAURAV//14//02//23
{
    Caption = 'Transcript';
    Direction = Import;
    FieldSeparator = ',';
    Format = VariableText;
    UseRequestPage = true;
    PreserveWhiteSpace = true;
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(integer; integer)
            {
                XmlName = 'Transcript';
                SourceTableView = sorting(Number);
                UseTemporary = true;
                TextElement(SclmNo)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInitRecord()
                begin

                    RowCount_gInt += 1;//GAURAV//17//02//23
                    //    IF FileContainHdrRow_gBln Then begin
                    if (RowCount_gInt = 1) then
                        currXMLport.Skip;
                    //  End;

                    Window_gDlg.Update(1, RowCount_gInt);
                    InitializeValues_lFnc;
                end;

                trigger OnBeforeInsertRecord()
                begin

                    EvaluateValue_lFnc;
                    InsertValues_lFnc;

                    currXMLport.Skip;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {

            }
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        Window_gDlg.Close;
        Message('Data Imported Successfully');
    end;

    trigger OnPreXmlPort()
    var
    begin

        RowCount_gInt := 0;
        Window_gDlg.Open(Text000 + Text001 + Text002);
    end;

    var
        RowCount_gInt: Integer;
        DocNo: Code[20];
        Window_gDlg: Dialog;
        InsertCount_gInt: Integer;
        SubCustomer_gCod: Code[20];
        IncomeType_gCod: Code[20];
        Text50000: label 'Do you want to Import Data?';
        Text50001: label '%1 - Gen. Journal Lines uploaded successfully.';
        Text50003: label '%3-Inserted Import PO Data';
        Text000: label 'Importing Data....\';
        Text001: label 'Row Count #1##############\';
        Text002: label 'Error Count #2##############';
        GLSetup_gRec: Record "General Ledger Setup";
        FileContainHdrRow_gBln: Boolean;
        StudentDivision_g: Code[20];//////
        MinAge_g: Integer;
        StudentID_g: Code[20];
        StudentName_g: Text[20];
        EnrollmentNo_g: Code[20];
        Print_g: Boolean;
        Reprint_g: Boolean;



    procedure InitializeValues_lFnc()
    begin

    end;

    procedure EvaluateValue_lFnc()
    var
    begin


    end;

    local procedure InsertValues_lFnc()
    var
        CompetitionLCS: Record "Competition L-CS";
        CompetitionLCS1: Record "Competition L-CS";
        StudentMasterCS: Record "Student Master-CS";
        CompetitionHCS: Record "Competition H-CS";
        Coursefilter: Text;
        LineNo: Integer;

    begin
        Coursefilter := 'AUA-GHT|FIU - AUA CLINICAL|FIUGLOBAL|STDPROG|SEMCOM|SEMCOM2|AUACOM|TRICOM';
        CompetitionLCS1.Reset();
        CompetitionLCS1.SetCurrentKey("Min Age");
        CompetitionLCS1.setrange("Document No.", DocNo);
        IF CompetitionLCS1.Findlast() Then
            LineNo := CompetitionLCS1."Min Age" + 10000
        Else
            LineNo := 10000;

        Clear(StudentMasterCS);
        StudentMasterCS.Reset();
        StudentMasterCS.SetCurrentKey("Enrollment Order");
        StudentMasterCS.SetFilter("Course Code", Coursefilter);
        StudentMasterCS.SetRange("Original Student No.", SclmNo);
        StudentMasterCS.Setrange("Global Dimension 1 Code", '9000');
        StudentMasterCS.FindFirst();


        CompetitionLCS.Init();
        CompetitionLCS."Document No." := DocNo;
        CompetitionLCS."Student Division" := Format(LineNo);
        CompetitionLCS."Min Age" := LineNo;
        CompetitionLCS.ValiDate("SLcM No", StudentMasterCS."No.");
        CompetitionLCS."Student ID" := StudentMasterCS."Original Student No.";
        CompetitionLCS."Student Name" := StudentMasterCS."Student Name";
        CompetitionLCS."Enrollment No" := StudentMasterCS."Enrollment No.";
        CompetitionLCS.Print := true;
        CompetitionLCS.Reprint := true;

        CompetitionLCS.Insert();




        // Clear(CompetitionHCS);//GAURAV//15//02//23
        // CompetitionHCS.Get(SclmNo);
        // CompetitionHCS."Last Print Date" := 0D;
        // CompetitionHCS."Competition Type" := '';
        // CompetitionHCS.modify;
        InsertCount_gInt += 1;
    end;

    procedure GetValue(var _DocNo: Code[20])
    Begin
        DocNo := _DocNo;
    End;


}

