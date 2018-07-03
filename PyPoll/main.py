
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
import os
import csv


# In[2]:


poll = "Resources/election_data.csv"
poll_df = pd.read_csv(poll)
poll_df.head()


# In[3]:


total_votes = poll_df["Voter ID"].count()
total_votes


# In[10]:


candidate_list=poll_df["Candidate"].unique()
print("the list of candidates: " , candidate_list)


# In[5]:


summary_poll = poll_df.groupby(["Candidate"]).count()
summary_poll.rename(index=str , columns={"Voter ID": "Total Vote Count"})
summary_poll["Percent of Total"] = summary_poll["Voter ID"] / total_votes


del summary_poll["County"]

summary_poll


# In[6]:



winner = summary_poll.loc[summary_poll['Percent of Total'].idxmax()]
winner
summary_poll["Percent of Total"] = pd.Series(["{0:.2f}%".format(val * 100) for val in summary_poll["Percent of Total"]], index = summary_poll.index)


# In[19]:


print("--text \nElection Results")
print()
print("Total Votes:", total_votes) 
print(summary_poll)
summary_poll.to_csv('output.csv',index=True, header=True)
print()
print("Winner: " , winner)

