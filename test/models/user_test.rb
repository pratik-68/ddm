# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without first name' do
    @user.first_name = nil
    refute @user.valid?, 'saved user without a first name'
    refute_nil @user.errors[:first_name],
               'null value in error in column first_name'
  end

  test 'invalid without last name' do
    @user.last_name = nil
    refute @user.valid?, 'saved user without a last name'
    refute_nil @user.errors[:last_name],
               'null value in error in column last_name'
  end

  test 'invalid without address' do
    @user.address = nil
    refute @user.valid?, 'saved user without a address'
    refute_nil @user.errors[:address],
               'null value in error in column address'
  end

  test 'invalid without email' do
    @user.email = nil
    refute @user.valid?, 'saved user without a email'
    refute_nil @user.errors[:email],
               'null value in error in column email'
  end

  test 'invalid email format1' do
    @user.email = 'example@example'
    refute @user.valid?, 'saved user invalid email id'
    refute_nil @user.errors[:email],
               'null value in error in column email'
  end

  test 'invalid email format2' do
    @user.email = 'e@e.i'
    refute @user.valid?, 'saved user invalid email id'
    refute_nil @user.errors[:email],
               'null value in error in column email'
  end

  test 'invalid without mobile number' do
    @user.mobile_number = nil
    refute @user.valid?, 'saved user without a mobile number'
    refute_nil @user.errors[:mobile_number],
               'null value in error in column mobile_number'
  end

  test 'invalid mobile number' do
    @user.mobile_number = 'example'
    refute @user.valid?, 'saved user invalid mobile_number'
    refute_nil @user.errors[:mobile_number],
               'null value in error in column mobile_number'

    @user.mobile_number = '12121'
    refute @user.valid?, 'saved user invalid mobile_number'
    refute_nil @user.errors[:mobile_number],
               'null value in error in column mobile_number'

    @user.mobile_number = '1234567890'
    refute @user.valid?, 'saved user invalid mobile_number'
    refute_nil @user.errors[:mobile_number],
               'null value in error in column mobile_number'

    @user.mobile_number = '1212121212121212'
    refute @user.valid?, 'saved user invalid mobile_number'
    refute_nil @user.errors[:mobile_number],
               'null value in error in column mobile_number'
  end

  test 'invalid without type_of_user' do
    @user.type_of_user = nil
    refute @user.valid?, 'saved user without a type_of_user'
    refute_nil @user.errors[:type_of_user],
               'null value in error in column type_of_user'
  end

  # test 'invalid type_of_user' do
  #   @user.type_of_user = 'abcd'
  #   refute @user.valid?, 'saved user invalid type_of_user'
  #   refute_nil @user.errors[:type_of_user],
  #              'null value in error in column type_of_user'
  # end

  test 'invalid without password_digest' do
    @user.password_digest = nil
    refute @user.valid?, 'saved user without a password_digest'
    refute_nil @user.errors[:password_digest],
               'null value in error in column password_digest'
  end

  test 'invalid without invite_count' do
    @user.invite_count = nil
    assert @user.valid?, 'saved user without a invite_count'
    assert_equal [], @user.errors[:invite_count],
                 'empty value in error in column invite_count'
  end

  test 'invalid invite_count' do
    @user.invite_count = -1
    refute @user.valid?, 'saved user with negative invite_count'
    refute_nil @user.errors[:invite_count],
               'null value in error in column invite_count'

    @user.invite_count = 26
    refute @user.valid?, 'saved user over max invite_count'
    refute_nil @user.errors[:invite_count],
               'null value in error in column invite_count'
  end

  test 'invalid without last_invite_at' do
    @user.last_invite_at = nil
    assert @user.valid?, 'saved user without a last_invite_at'
    assert_equal [], @user.errors[:last_invite_at],
                 'null value in error in column last_invite_at'
  end

  test 'invalid without last_sign_in' do
    @user.last_sign_in = nil
    assert @user.valid?, 'saved user without a last_sign_in'
    assert_equal [], @user.errors[:last_sign_in],
                 'null value in error in column last_sign_in'
  end
end
