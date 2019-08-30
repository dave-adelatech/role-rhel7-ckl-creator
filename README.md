Role Name
=========

Role 'role-rhel7-ckl-creator' is the collection of ansible RHEL 7 STIG checks based on the DISA STIG checklist.

Requirements
------------

This repository is designed to run on Ansible 2.7.7 on RHEL 7.  Currently, the tool is initiated at the command line, and it is required that the necessary credential configuration is in place to permit Ansible to SSH to the target hosts to execute the STIG checks.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

See repository 'playbook-stig-rhel7'.

Example Playbook
----------------

See repository 'playbook-stig-rhel7', which contains the master playbook 'redhat-7-master-playbook.yml' that initiates the RHEL 7 STIG checklist.  This playbook in turn imports the master role 'role-rhel7-ckl-creator' found in this repository by the same name.

Within this repository, see 'tasks/main.yml' which is the master task file that imports all the individual STIG tasks, including both the 'prep.yml' and 'post.yml' tasks.


License
-------

Proprietary, Smartronix / US Navy NAVAIR NAWCAD.

Author Information
------------------

The playbooks were a combined effort by many dedicated Unix admins, most notably: Andrew Darley, Josha Loscar, John Faber, Jordan Tyler, & Nate Vanucci.
