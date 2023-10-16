xmlport 50080 "Upload Student Hold"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Integer; Integer)

            {
                XmlName = 'StudentHolds';
                textelement(StudentNo)
                {

                }
                textelement(HoldName)
                {

                }
                trigger OnBeforeInsertRecord()
                var
                    StudentHoldRec: Record "Student Hold";
                    StudentWiseHold: Record "Student Wise Holds";
                    StudentMasterRec: Record "Student Master-CS";
                    RSL: Record "Roster Scheduling Line";
                    //   StudentGroupRec: Record "Student Group";
                    StudentStatusMangementCod: Codeunit "Hold Bulk Upload";
                begin
                    If SkipFirstLine then begin
                        SkipFirstLine := False;
                    end Else begin
                        If (StudentNo = '') OR (HoldName = '') then
                            Error('Student No or Hold Name must have a value');

                        // StudentMasterRec.Get(StudentNo);
                        StudentMasterRec.Reset();
                        StudentMasterRec.SetRange("Original Student No.", StudentNo);
                        if StudentMasterRec.FindSet() then
                            repeat

                                StudentHoldRec.Get(HoldName, StudentMasterRec."Global Dimension 1 Code");

                                if StudentHoldRec."Hold Type" IN [StudentHoldRec."Hold Type"::Bursar, StudentHoldRec."Hold Type"::"Financial Aid", StudentHoldRec."Hold Type"::Housing] then begin
                                    if HoldEnableDisable = HoldEnableDisable::Enable then begin
                                        StudentStatusMangementCod.EnableAllHoldOLR(StudentMasterRec, StudentHoldRec."Hold Type");
                                        StudentStatusMangementCod.AssignStudentBulkGroup(StudentNo, StudentHoldRec."Group Code");
                                    end;

                                    if HoldEnableDisable = HoldEnableDisable::Disable then begin
                                        StudentStatusMangementCod.DisableAllHoldOLR(StudentMasterRec, StudentHoldRec."Hold Type");
                                        StudentStatusMangementCod.UnassignStudentBulkGroup(StudentNo, StudentHoldRec."Group Code");
                                        //CSPL-00307-RTP As per Ajay 16-03-23
                                        IF StudentHoldRec."Hold Type" = StudentHoldRec."Hold Type"::Bursar Then begin
                                            RSL.AutoPublishedRotation_On_CLN_Hold_Removed(StudentMasterRec);
                                        end;
                                        //CSPL-00307-RTP As per Ajay 16-03-23
                                    end;
                                end;

                                if StudentHoldRec."Hold Type" = StudentHoldRec."Hold Type"::Registrar then begin

                                    if HoldEnableDisable = HoldEnableDisable::Enable then begin
                                        StudentStatusMangementCod.EnableRegistrarBulkHold(StudentMasterRec, StudentHoldRec."Hold Type");
                                        StudentStatusMangementCod.AssignStudentBulkGroup(StudentNo, StudentHoldRec."Group Code");
                                    end;
                                    if HoldEnableDisable = HoldEnableDisable::Disable then begin
                                        StudentStatusMangementCod.DisableRegistrarBulkHold(StudentMasterRec, StudentHoldRec."Hold Type");
                                        StudentStatusMangementCod.UnassignStudentBulkGroup(StudentNo, StudentHoldRec."Group Code");
                                    end;
                                end;

                                if StudentHoldRec."Hold Type" = StudentHoldRec."Hold Type"::" " then begin

                                    if HoldEnableDisable = HoldEnableDisable::Enable then begin
                                        StudentStatusMangementCod.AssignStudentWiseBulkHold(StudentNo, StudentHoldRec."Group Code");
                                        StudentStatusMangementCod.AssignStudentBulkGroup(StudentNo, StudentHoldRec."Group Code");
                                    end;
                                    if HoldEnableDisable = HoldEnableDisable::Disable then begin
                                        StudentStatusMangementCod.UnassignStudentWiseBulkHold(StudentNo, StudentHoldRec."Group Code");
                                        StudentStatusMangementCod.UnassignStudentBulkGroup(StudentNo, StudentHoldRec."Group Code");
                                    end;

                                end;
                            Until StudentMasterRec.Next() = 0;
                    end;
                    currXMLport.Skip();
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field("Hold Enable Disbale"; HoldEnableDisable)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnInitXmlPort()
    begin

    end;

    trigger OnPreXmlPort()
    var
    begin
        SkipFirstLine := True;
        If HoldEnableDisable = HoldEnableDisable::" " then
            Error('Please select either Hold Enable or Hold Disable');
    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Uploaded Sucessfully !');
    end;

    Var
        HoldEnableDisable: Option " ",Enable,Disable;
        SkipFirstLine: Boolean;

}
