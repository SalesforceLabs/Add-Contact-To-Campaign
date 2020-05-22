/*
Copyright (c) 2011, salesforce.com, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, 
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.
    * Neither the name of the salesforce.com, Inc. nor the names of its contributors 
    may be used to endorse or promote products derived from this software 
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
OF THE POSSIBILITY OF SUCH DAMAGE.

*/
@isTest
private class AddContactToCampaignTests {
    static testMethod void addContactToCampaignTest() {
        Account acc = new Account();
        acc.BillingCountry = 'US';
        acc.ShippingCountry = 'US';
        acc.BillingState = 'IL';
        acc.Name = 'Test Acc';
        insert acc;

        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.FirstName = 'Jane';
        con.LastName = 'Doe';
        insert con;

        Campaign cam1 = new Campaign();
        cam1.Name = 'Test Cam 1';
        insert cam1;

        ApexPages.Standardcontroller con1 = new ApexPages.Standardcontroller(
            con
        );
        AddContactToCampaignController actc = new AddContactToCampaignController(
            con1
        );
        actc.cmem.CampaignId = cam1.Id;
        actc.cmem.Status = 'Sent';
        actc.save();

        List<CampaignMember> camMems = [
            SELECT Id
            FROM CampaignMember
            WHERE CampaignId = :cam1.Id
        ];
        System.assertEquals(1, camMems.size());
    }
}
