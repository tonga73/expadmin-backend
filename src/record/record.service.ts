import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Record, Prisma } from '@prisma/client';

@Injectable()
export class RecordService {
  constructor(private prisma: PrismaService) {}

  async records(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.RecordWhereUniqueInput;
    where?: Prisma.RecordWhereInput;
    orderBy?: Prisma.RecordOrderByWithRelationInput;
  }): Promise<Record[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.record.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  async createRecord(data: Prisma.RecordCreateInput): Promise<Record> {
    return this.prisma.record.create({
      data,
    });
  }
}
