xmlport 50079 "Upload Student Holds"
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
                    RSL: Record "Roster Scheduling Line"; //CSPL-00307-RTP
                    DepartmentApprovalUser: Record "Document Approver Users";
                    StudentGroup: Record "Student Group";//CS_SG 20230523
                    StudentStatusMangementCod: Codeunit "Student Status Mangement";
                    HoldBulkUpload: Codeunit "Hold Bulk Upload";

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

                                IF StudentHoldRec."Hold Type" = StudentHoldRec."Hold Type"::"OLR Finance" then begin
                                    DepartmentApprovalUser.Reset();
                                    DepartmentApprovalUser.SetRange("User ID", UserId());
                                    DepartmentApprovalUser.SetFilter("Department Approver Type", '%1|%2', DepartmentApprovalUser."Department Approver Type"::"Bursar Department", DepartmentApprovalUser."Department Approver Type"::"Financial Aid Department");
                                    If not DepartmentApprovalUser.FindFirst() then
                                        Error('Only the bursar and the financial aid department have the permission to enable or disable OLR finance.');
                                end;

                                if StudentHoldRec."Hold Type" IN [StudentHoldRec."Hold Type"::Bursar, StudentHoldRec."Hold Type"::"Financial Aid", StudentHoldRec."Hold Type"::Housing, StudentHoldRec."Hold Type"::"OLR Finance"] then begin
                                    if HoldEnableDisable = HoldEnableDisable::Enable then begin
                                        StudentStatusMangementCod.EnableAllHoldOLR(StudentMasterRec, StudentHoldRec."Hold Type");
                                    end;

                                    if HoldEnableDisable = HoldEnableDisable::Disable then begin
                                        StudentStatusMangementCod.DisableAllHoldOLR(StudentMasterRec, StudentHoldRec."Hold Type");
                                        //CSPL-00307-RTP As per Ajay 15-03-23
                                        IF StudentHoldRec."Hold Type" = StudentHoldRec."Hold Type"::Bursar Then begin
                                            RSL.AutoPublishedRotation_On_CLN_Hold_Removed(StudentMasterRec);
                                        end;
                                        //CSPL-00307-RTP As per Ajay 15-03-23
                                    end;
                                    // end;
                                    // Else
                                    //  StudentStatusMangementCod.EnableAllHoldOLR(StudentMasterRec, StudentHoldRec."Hold Type");
                                end;

                                if StudentHoldRec."Hold Type" = StudentHoldRec."Hold Type"::Registrar then begin
                                    if HoldEnableDisable = HoldEnableDisable::Enable then
                                        StudentStatusMangementCod.EnableRegistrarBulkHold(StudentMasterRec, StudentHoldRec."Hold Type");
                                    if HoldEnableDisable = HoldEnableDisable::Disable then
                                        StudentStatusMangementCod.DisableRegistrarBulkHold(StudentMasterRec, StudentHoldRec."Hold Type");

                                end;
                                if StudentHoldRec."Hold Type" = StudentHoldRec."Hold Type"::" " then begin

                                    if HoldEnableDisable = HoldEnableDisable::Enable then begin
                                        HoldBulkUpload.AssignStudentWiseBulkHold(StudentNo, StudentHoldRec."Group Code");
                                        HoldBulkUpload.AssignStudentBulkGroup(StudentNo, StudentHoldRec."Group Code");
                                    end;
                                    if HoldEnableDisable = HoldEnableDisable::Disable then begin
                                        HoldBulkUpload.UnassignStudentWiseBulkHold(StudentNo, StudentHoldRec."Group Code");
                                        HoldBulkUpload.UnassignStudentBulkGroup(StudentNo, StudentHoldRec."Group Code");
                                    end;
                                end;
                                //CS_SG 20230523
                                if StudentHoldRec."Hold Type" = StudentHoldRec."Hold Type"::"OLR Finance" then
                                    if HoldEnableDisable = HoldEnableDisable::Disable then
                                        HoldBulkUpload.CondRegistrationGroupDisable(StudentNo);


                            //CS_SG 20230523
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
